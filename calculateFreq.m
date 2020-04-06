function total_freq = calculateFreq(sheetNumber)

MTFiles = dir('*.xls');
numfiles = length(MTFiles);
xlRange = 'F1:F99';           %% writes only the column containing frequency values
numCells = length(sheetNumber); %% how many cells are being analyzed

total_freq = zeros(1,numCells);

for i = 1:numCells
    currentCell = sheetNumber(i); %% establish this as the cell being analyzed
    frequency = zeros(99,30);   %% create a matrix containing frequency for all bins on all laps for current cell
    for j = 1:numfiles
        filename = MTFiles(j);  %% loops through each lap file for the current cell, writing its frequency data
        frequency(:,j) = xlsread(filename.name,currentCell,xlRange);
        
       
    end
    
    freqLap = mean(frequency);
    
    total_freq(i) = mean(freqLap);
    
end
end
 