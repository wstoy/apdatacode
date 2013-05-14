function [  ] = cell_characteristics(  )
%cell_characteristics displays/plots all the important cell characteristics
%   Finds all_recorded_trials.mat file in folder 'combinedAnalysis'.
%%

load('..\combinedAnalysis\all_recorded_trials.mat')

allDepths = [all_recorded_trials.finalDepth];
allRa = [all_recorded_trials.Ra];
allRm = [all_recorded_trials.Rm];
allCm = [all_recorded_trials.Cm];
allIh = [all_recorded_trials.Ih];
allMaxR = [all_recorded_trials.maxR];
allRMP = [all_recorded_trials.RMP];
allHoldingTime = [all_recorded_trials.holding_time];
allRin = [all_recorded_trials.Rin];

figure
plot(allDepths, allRa*1e-6, 'o', 'linewidth', 2)
title('Access resistance (Ra)', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('R (M\Omega)', 'fontsize', 12)

figure
plot(allDepths, allRm*1e-6, 'o', 'linewidth', 2)
title('Membrane resistance (Rm)', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('R (M\Omega)', 'fontsize', 12)

figure
plot(allDepths, allCm*1e12, 'o', 'linewidth', 2)
title('Membrane capacitance (Cm)', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('C_m (pF)', 'fontsize', 12)

figure
plot(allDepths, allIh, 'o', 'linewidth', 2)
title('Holding current (pA)', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('I_h (pA)', 'fontsize', 12)

figure
plot(allDepths, allMaxR, 'o', 'linewidth', 2)
title('Gigasealing resistance', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('R (M\Omega)', 'fontsize', 12)

figure
plot(allDepths, allRMP, 'o', 'linewidth', 2)
title('Resting potential', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('RMP (mV)', 'fontsize', 12)

figure
plot(allDepths, allRin*1e-6, 'o', 'linewidth', 2)
title('Input Resistance', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('R (M\Omega)', 'fontsize', 12)

figure
plot(allDepths, allHoldingTime/60, 'o', 'linewidth', 2) % holding time in minutes
title('Holding Time', 'fontsize' ,12)
xlabel('Depth (\mum)', 'fontsize', 12)
ylabel('Holding time (min)', 'fontsize', 12)
end

