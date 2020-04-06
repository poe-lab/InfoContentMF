function [infoContentPerSpike_fam, infoContentPerSpike_rev] = calculateInfo(sheetNumber)

[Pi_familiar, Pi_reversal,familiarMazeOcc,reversalMazeOcc] = occTime;

[total_Ri_fam, total_Ri_rev,R_fam,R_rev] = firingRatePerBin(sheetNumber,familiarMazeOcc,reversalMazeOcc);
infoContentPerSpike_fam = zeros(1,length(total_Ri_fam));

infoContentPerSpike_rev = zeros(1,length(total_Ri_rev));

for i = 1:length(total_Ri_fam)
    currentRi = total_Ri_fam{1,i};
    RiOverR = currentRi./R_fam(i);
    infoTemp = zeros(99,1);
    
    for j = 1:length(currentRi)
        infoTemp(j) = Pi_familiar(j)*RiOverR(j)*log2(RiOverR(j));
    end
    infoContentPerSpike_fam(i) = nansum(infoTemp);
        
end

for i = 1:length(total_Ri_rev)
    currentRi = total_Ri_rev{1,i};
    RiOverR = currentRi./R_rev(i);
    infoTemp = zeros(99,1);
    
    for j = 1:length(currentRi)
        infoTemp(j) = Pi_reversal(j)*RiOverR(j)*log2(RiOverR(j));
    end
    infoContentPerSpike_rev(i) = nansum(infoTemp);
end
end


