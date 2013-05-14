function [ recSegment ] = parse_whisker_stim_folder_file( whisker_folder_file )
%parse_whisker_stim_folder_file Summary of this function goes here
%   Detailed explanation goes here
    
    lvm_file = lvm_import(whisker_folder_file);
    
    segment = lvm_file.Segment1;
    
    v = segment.data(:,1); % neural voltage
    sense = segment.data(:,2); % motor sense current
    stim = segment.data(:,3); % current clamp
    
    stim = mean(stim); % mean stimulation amplitude
    
    comment = segment.Comment;
    [ protocolName, triangle, pulse ] = parseComment( comment );
    
    recSegment.v = v;
    recSegment.sense = sense;
    recSegment.stim = stim;
    recSegment.protocolName = protocolName;

    if strcmp(protocolName, 'triangle')
        recSegment.triangle = triangle;
    elseif strcmp(protocolName, 'pulse')
        recSegment.pulse = pulse;
    end
    
    diffThreshold = 0.1;
    
    % Not done yet - this will define stimOnset and stimOffset
    recSegment.stimOnsetIndex = find(diff(sense) > .1, 1);
    recSegment.stimOutsetIndex = find(diff(sense) < .1, 1);
    
end

