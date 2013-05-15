function [ recData ] = parse_whisker_stim_folder_file( whisker_folder_file )
%parse_whisker_stim_folder_file Summary of this function goes here
%   Detailed explanation goes here
    
    lvm_file = lvm_import(whisker_folder_file);
    
    segment = lvm_file.Segment1;
    
    v = segment.data(:,1); % neural voltage
    sense = segment.data(:,2); % motor sense current
    stim = segment.data(:,3); % current clamp
    
    stim = mean(stim); % mean stimulation amplitude
    
    comment = segment.Comment;
    [ protocolName, triangle, pulseTrain, exponential] = parseComment( comment );
    
    recData.v = v;
    recData.sense = sense;
    recData.stim = stim;
    recData.protocolName = protocolName;

    if strcmp(protocolName, 'triangle')
        recData.triangle = triangle;
        recData.pulseTrain = [];
        recData.exponential = [];
    elseif strcmp(protocolName, 'pulsetrain')
        recData.pulseTrain = pulseTrain;
        recData.triangle = [];
        recData.exponential = [];
    elseif strcmp(protocolName, 'exponential')
        recData.exponential = exponential;
        recData.pulseTrain = [];
        recData.triangle = [];
    else
        error('parse_whisker_stim_folder error: protocolName not found!')
    end
    
    diffThreshold = 0.1;
    
    % Not done yet - this will define stimOnset and stimOffset
    recData.stimOnsetIndex = find(diff(sense) > .1, 1);
    recData.stimOutsetIndex = find(diff(sense) < .1, 1);
    
end

