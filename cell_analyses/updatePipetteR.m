%% updatePipetteR.m
% Update the combinedRMP.mat strucure with a new set of values

function [] = updatePipetteR(pipetteRList)
load('..\combinedAnalysis\combinedpipetteRList.mat')
% append the new values to the combined rmp list
combinedpipetteRList = [combinedpipetteRList; pipetteRList];
save('..\combinedAnalysis\combinedpipetteRList.mat', 'combinedpipetteRList')
end