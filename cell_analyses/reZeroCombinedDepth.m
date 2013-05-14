%% rezerCombinedDepth
% Creates the combinedDepth structure anew

combinedDepth = struct('FolderName', {}, 'depths', []);
save('..\combinedAnalysis\combinedDepth.mat', 'combinedDepth')
clearvars combinedDepth % so as to not confuse with local variable