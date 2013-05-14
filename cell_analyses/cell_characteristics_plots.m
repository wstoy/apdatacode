%% cell_characteristics_plots.m
% Create depths vs everything else plots

function [] = cell_characteristics_plots()
load('..\combinedAnalysis\combinedDepth.mat') % depth
load('..\combinedAnalysis\combinedrmpList.mat') % rmp
load('..\combinedAnalysis\combinedpipetteRList.mat') % pipette R

d = [combinedDepth.depths]'; % recording depths
rmp = [combinedrmpList.rmp]';
pipetteR = [combinedpipetteRList.R]';

% Depth vs RMP
figure, plot(d, rmp, 'o', 'linewidth', 3)
xlabel('Depth (um)')
ylabel('RMP (mV)')

figure, plot(d, pipetteR, 'o', 'linewidth', 3)
xlabel('Depth (um)')
ylabel('Pipette R (MOhms)')

wholeCellRMP = rmp(rmp<-50);

disp(['RMP (under -50 mV) = ' num2str(mean(wholeCellRMP))...
    ' +/- ' num2str(std(wholeCellRMP)) '. N = ' int2str(length(wholeCellRMP))])
disp(['pipette R = ' num2str(mean(pipetteR)) ' +/- ' num2str(std(pipetteR))])
end