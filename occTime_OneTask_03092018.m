function [Pi_occ,mazeOcc] = occTime_OneTask_03092018

%% function adds up all occupancy times per bin for an entire track during one session (for example, all 15 runs of a familiar or reversal maze)
% no input required, just have to run this in a folder where you have
% stored all of the MT files generated during place cell identification.
% Make sure that the directory formed has MT files in numerical order

MTFiles = dir('*.xls');
numfiles = length(MTFiles);
numLaps = 15;
OccData = zeros(99,numLaps);
xlRange = 'B1:B99';    %% writes only column containing occupancy data
for i = 1:numfiles            %% loops through files from each lap and writes occupancy data into a matrix.
    filename = MTFiles(i);
    OccData(:,i) = xlsread(filename.name,xlRange);  % rows correspond to bin(99), columns to each lap(15)
    for j = 1:length(OccData)
        if OccData(j,i) > 0.6
            OccData(j,i)= NaN;
        end
    end
    
end
mazeOcc = nansum(OccData(:,1:15),2);    %% adds together columns from first 15 laps to sum bin occupancy data for familiar maze

mazeTotalTime = sum(mazeOcc); %% sum of total maze time

Pi_occ = mazeOcc./mazeTotalTime; %% Pi is occupancy probability, found by dividing the occupancy time of each bin by the total time of the maze

end



    