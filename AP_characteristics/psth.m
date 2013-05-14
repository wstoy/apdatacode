%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% psth : Peristimulus Time Histogram
% William Stoy
% 
% db                : structure of stimulus (array of structures)
% fs                : sampling frequency (Hz)
% sBefore           : samples to display before (samples)
% sAfter            : samples to display after onset of stimulus (samples)
% responseWindow    : length of response window (starting at stimulus onset)
% binWidth          : width of bins (s)

function [] = psth(motorStimOnsets, APindices, fs, sBefore, sAfter, responseWindow, binWidth)
    %check that the database has the proper fields
%     if ~isfield(db, {'APindices','motorStimOnset'})
%         error('psth:MissingFields','The database is missing some fields');
%     end
    if length(motorStimOnsets) ~= size(APindices,1)
       error('psth:dimMismatch','MotorStimOnsets and APindices must be the same length'); 
    end
    
    tAfter = sAfter/fs;     % (s)
    tBefore = sBefore/fs;   % (s)
    responseWindow = responseWindow/fs; % (s)
    binWidth = binWidth/fs; % (s)
    
    % LOOK AND FEEL
    boxcolor = [0.7,0.7,0.7];
    spikeColor = 'ko';
    responseColor = 'ro';
    
    figure;
    subplot(2,1,1); hold on;
    %display the window (grey box)
    h = rectangle('Position',[0,0,responseWindow,length(motorStimOnsets)-1],'FaceColor',boxcolor,'EdgeColor',boxcolor);
    AllAPtimes = [];
    
    %loop through trials and display the points
    for i = 1:length(motorStimOnsets)
        normAPindices = APindices(i,:) - motorStimOnset(i);
        normAPtimes = normAPindices./fs;
        APtimes = normAPtimes(normAPtimes > -tBefore & normAPtimes < tAfter);
        
        yvals = (i-1)*ones(length(APtimes));
        plot(APtimes,yvals,spikeColor);
        AllAPtimes = [AllAPtimes, APtimes];
        
        %overlay plot with emphasis on spikes within the plot window
        responseAPtimes = APtimes(APtimes >= 0 & APtimes <= responseWindow);
        plot(responseAPtimes,yvals(1:length(responseAPtimes)),responseColor);
    end
    
    
    xlim([-tBefore, tAfter]); ylim([-.1,length(db)-1+.1]);
    ylabel('Trials');
    
    subplot(2,1,2);
    binCenters = linspace(-tBefore,tAfter-1,round((tAfter + tBefore)/binWidth)); % (s)
    binWidth = mean(diff(binCenters)); % (s)
    
    hist(AllAPtimes, binCenters);
    xlim([-tBefore, tAfter]);
    xlabel('Time from stimulus onset (s)');
    ylabel('Binned Responses');
end