function [Pi_familiar, Pi_reversal,familiarMazeOcc,reversalMazeOcc] = occTime

%% function adds up all occupancy times per bin for an entire maze (for example, all 15 runs of a familiar or reversal maze)
% no input required, just have to run this in a folder where you have
% stored all of the MT files generated during place cell identification.
% Make sure that the directory formed has MT files in numerical order

MTFiles = dir('*.xls');
numfiles = length(MTFiles);
OccData = zeros(99,30);
xlRange = 'B1:B99';    %% writes only column containing occupancy data
for i = 1:numfiles            %% loops through files from each lap and writes occupancy data into a matrix.
    filename = MTFiles(i);
    OccData(:,i) = xlsread(filename.name,xlRange);  % rows correspond to bin(99), columns to each lap(30)
    for j = 1:length(OccData)
        if OccData(j,i) > 0.6
            OccData(j,i)= NaN;
        end
    end
    
end
familiarMazeOcc = nansum(OccData(:,[1:15]),2);    %% adds together columns from first 15 laps to sum bin occupancy data for familiar maze

reversalMazeOcc = nansum(OccData(:,[16:30]),2);   %% adds together columns from last 15 laps to sum bin occupancy data for reversal maze

familiarMazeTotalTime = sum(familiarMazeOcc); %% sum of total familiar maze time
reversalMazeTotalTime = sum(reversalMazeOcc); %% sum of total reversal maze time

Pi_familiar = familiarMazeOcc./familiarMazeTotalTime; %% Pi is occupancy probability, found by dividing the occupancy time of each bin by the total time of the maze
Pi_reversal = reversalMazeOcc./reversalMazeTotalTime;

end



    