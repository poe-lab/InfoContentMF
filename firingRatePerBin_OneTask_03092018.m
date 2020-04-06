function [total_Ri, R_maze] = firingRatePerBin_OneTask_03092018(sheetNumber,mazeOcc)

%% calculates the firing rate per bin for each cell on a session of a track
% sheetNumber is a vector containing all of the values for the sheets
% corresponding to the cells that you want to analyze. mazeOcc is generated in occTime_OneTask_03092018.m
MTFiles = dir('*.xls');
numfiles = length(MTFiles);
xlRange = 'E1:E99';           % writes only the column containing origingal spike values from the Guassian smoothed "*_out.xls" file
numCells = length(sheetNumber); % how many cells are being analyzed

total_Ri = cell(1,numCells); % cell array containing the resulting Ri values for each cell

R_maze = zeros(1,numCells);
numLaps = 15;
for i = 1:numCells
    currentCell = char(sheetNumber(i)); % establish this as the cell being analyzed
    spikeCount = zeros(99,numLaps);   %% create a matrix containing spike counts for all bins on all laps for current cell
    for j = 1:numfiles
        filename = MTFiles(j);  % loops through each lap file for the current cell, writing its spike count data
        spikeCount(:,j) = xlsread(filename.name,currentCell,xlRange); 
    end
        
    spikeCount_sum = sum(spikeCount,2);   % this adds together spike data across columns for all laps of the track during the session. 
    Ri_maze = spikeCount_sum./mazeOcc;
    for ii = 1:length(Ri_maze)
        if Ri_maze(ii) == Inf
            Ri_maze(ii) = NaN;
        end
    end
    R_maze(1,i) = nansum(Ri_maze)/99;
    total_Ri{i} = Ri_maze;    
end

end