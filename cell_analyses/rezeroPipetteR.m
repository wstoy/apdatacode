%% rezeroPipetteR
% Creates the combinedrmpList structure anew

combinedpipetteRList = struct('FolderName', {}, 'R', []);
save('..\combinedAnalysis\combinedpipetteRList.mat', 'combinedpipetteRList')
clearvars combinedpipetteRList % so as to not confuse with local variable