%% updateCombinedRMP.m
% Update the combinedRMP.mat strucure with a new set of values

function [] = updateCombinedRMP(rmpList)
load('..\combinedAnalysis\combinedrmpList.mat')
% append the new values to the combined rmp list
combinedrmpList = [combinedrmpList; rmpList];
save('..\combinedAnalysis\combinedrmpList.mat', 'combinedrmpList')
end