%% rezerCombinedRMP
% Creates the combinedrmpList structure anew

combinedrmpList = struct('FolderName', {}, 'rmp', []);
save('..\combinedAnalysis\combinedrmpList.mat', 'combinedrmpList')
clearvars combinedrmpList % so as to not confuse with local variable