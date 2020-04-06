function [infoContentPerSpike_maze] = calculateInfo_OneTask_03092018(sheetNumber)

[Pi_occ,mazeOcc] = occTime_OneTask_03092018;

[total_Ri, R_maze] = firingRatePerBin_OneTask_03092018(sheetNumber,mazeOcc);

infoContentPerSpike_maze = zeros(1,length(total_Ri));

for i = 1:length(total_Ri)
    currentRi = total_Ri{1,i};
    RiOverR = currentRi./R_maze(i);
    infoTemp = zeros(99,1);
    
    for j = 1:length(currentRi)
        infoTemp(j) = Pi_occ(j)*RiOverR(j)*log2(RiOverR(j));
    end
    infoContentPerSpike_maze(i) = nansum(infoTemp);
        
end

end


