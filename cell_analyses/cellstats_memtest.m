function [Rm, Ra, Cm, Ih, Rin] = cellstats_memtest(wvfrm, stim_onset_index, stim_offset_index, deltaV)
%% cellstats_memtest.m
%   Finds cell stats (Ra, Rm, Cm, Rin) from the membrane test.
%   Inputs: wvfrm: result of membrane test measurement.
%           stim_onset_index:  Index at which the command voltage goes high
%           stim_offset_index: Index at which the command voltage returns
%           to baseline
%           deltaV:            Pulse amplitude of the command voltage (mV)
%   Outputs: Rm: Membrane resistance
%            Ra: Access resistance
%            Cm: Membrane capacitance
%            meanflatSegment1: holding current
%            Rin: input resistance measured using deltaV/deltaI

    deltaV = deltaV/1000; % deltaV in volts
    wvfrm = wvfrm/(1e12); % convert picoAmps to Amps (SI units)
    numSamples = length(wvfrm); % number of samples in waveform
    percentSamplestoUse = 10; % percentage of number of samples to use in flat segments
    samplingRate = 20000; % sampling rate (Hz)
    
    f = figure('Name', 'Membrane test waveform');
    plot(wvfrm);
    xlabel('T (samples)')
    
    flatSegment1_indices = 500:500+round(percentSamplestoUse/100*numSamples); % ignore first 100 samples
    flatSegment2_indices = stim_offset_index-round(percentSamplestoUse/100*numSamples):stim_offset_index-5; % offset by 5 data points
    flatSegment1 = wvfrm(flatSegment1_indices );
    flatSegment2 = wvfrm(flatSegment2_indices ); % 
    
    hold on, plot(flatSegment1_indices, flatSegment1, 'r', 'linewidth' ,2)
    plot(flatSegment2_indices, flatSegment2, 'r', 'linewidth' ,2)
    
    meanflatSegment2 = mean(flatSegment2);
    meanflatSegment1 = mean(flatSegment1);
    stdflatSegment2 = std(flatSegment2);
    
    deltaI = meanflatSegment2 - meanflatSegment1; % in Amps
    % ABS SHOULD BE UNNECESSARY!!
    if deltaI < 0
        choice = input('Delta I < 0! Make abs and continue? [y] /n : ', 's');
        switch choice
            case 'y'
                deltaI = abs(deltaI);
            otherwise
                return 
        end
    end
    %% Getting exponential
    
    exp1Wvfrm = wvfrm(stim_onset_index:flatSegment2_indices(1)); % find the exponential curve
    
    [tau, scaledExpWvfrm, plotExpWvfrm] = fitExp(exp1Wvfrm, meanflatSegment2, stdflatSegment2, samplingRate);
    
    plotExpIndices = stim_onset_index+1:stim_onset_index + length(plotExpWvfrm);
    
    figure(f); plot(plotExpIndices, plotExpWvfrm, 'r', 'linewidth', 2)
    
    % calculations
    Q1 = trapz(scaledExpWvfrm)*1/samplingRate; % in seconds
    Q2 = deltaI*tau; % in coulombs
    Qt = Q1+Q2; % in coulombs
    
    Rt = deltaV / deltaI; % volts / Amps = ohms
    Cm = Qt / deltaV; % in farads
    
    disp(['Cm = ' num2str(Cm*1e12) ' pF'])
    
    % find roots
%     Raguess = 10e6; % guess 10 Megaohms = 10 000 000 ohms
%     fun = @(Ra) Ra^2-Ra*Rt+Rt*(tau/Cm);
    %Ra = fzero(fun, Raguess); % in ohms
    Ra_roots = roots([1 -1*Rt Rt*tau/Cm]);
    
    if length(Ra_roots) == 2
        in = input(['Possible roots are 1. Ra = ' num2str(Ra_roots(1)/1e6) ' MOhms or 2. Ra = ' ...
            num2str(Ra_roots(2)/1e6) ' MOhms. Which one [1 or 2]?  ']);
        Ra = Ra_roots(in);
    else
        Ra = Ra_roots(1);
    end
    disp(['Ra = ' num2str(Ra/1e6) ' MOhms'])
    
    Rm = Rt-Ra; % in ohms
    disp(['Rm = ' num2str(Rm/1e6) ' MOhms'])
    
    Ih = meanflatSegment1*1e12;
    disp(['Ih = ' num2str(Ih) ' pA'])
    
    Rin = deltaV/deltaI; % in Ohms
    disp(['Rin = ' num2str(Rin/10^6) ' MOhms'])
    if isnan(Ra)
        disp('Ra is NaN, recheck std in fitExp')
        pause
    end
end