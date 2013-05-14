%% updateCombinedDepth.m
% Update the combinedDepth.mat strucure with a new set of values

function [] = updateCombinedDepth(depthList)
load('..\combinedAnalysis\combinedDepth.mat')
% append the new values to the combined depth list
combinedDepth = [combinedDepth; depthList];
save('..\combinedAnalysis\combinedDepth.mat', 'combinedDepth')
end