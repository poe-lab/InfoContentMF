function [total_Ri_fam,total_Ri_rev,R_fam,R_rev] = firingRatePerBin(sheetNumber,familiarMazeOcc,reversalMazeOcc)

%% calculates the firing rate per bin for each cell on the reversal and familiar maze
% sheetNumber is a vector containing all of the values for the sheets
% corresponding to the cells that you want to analyze. familiarMazeOcc and
% reversalMazeOcc are generated in occTime.m
MTFiles = dir('*.xls');
numfiles = length(MTFiles);
xlRange = 'C1:C99';           %% writes only the column containing spike values
numCells = length(sheetNumber); %% how many cells are being analyzed

total_Ri_fam = cell(1,numCells); %%cell array containing the resulting Ri values for each cell
total_Ri_rev = cell(1,numCells);

R_fam = zeros(1,numCells);
R_rev = zeros(1,numCells);

for i = 1:numCells
    currentCell = sheetNumber(i); %% establish this as the cell being analyzed
    spikeCount = zeros(99,30);   %% create a matrix containing spike counts for all bins on all laps for current cell
    for j = 1:numfiles
        filename = MTFiles(j);  %% loops through each lap file for the current cell, writing its spike count data
        spikeCount(:,j) = xlsread(filename.name,currentCell,xlRange);
        
       
    end
    
    
    spikeCount_fam = sum(spikeCount(:,[1:15]),2);   %% this adds together spike data across columns for first 15 laps (familiar maze). 
    Ri_fam = spikeCount_fam./familiarMazeOcc;
    for ii = 1:length(Ri_fam)
        if Ri_fam(ii) == Inf
            Ri_fam(ii) = NaN;
        end
    end
    R_fam(1,i) = nansum(Ri_fam)/99;
    
    spikeCount_rev = sum(spikeCount(:,[16:30]),2);
    Ri_rev = spikeCount_rev./reversalMazeOcc;
    for ii = 1:length(Ri_rev)
        if Ri_rev(ii) == Inf
            Ri_rev(ii) = NaN;
        end
    end
    R_rev(:,i) = nansum(Ri_rev)/99;
    
    total_Ri_fam{i} = Ri_fam;
    total_Ri_rev{i} = Ri_rev;
    
end
end