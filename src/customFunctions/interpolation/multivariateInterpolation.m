function interpolatedPoint = multivariateInterpolation(parameterSet, obsSet, point)

    %obsSet = syntheticData(:,1:10:end);
    %parameterSet = allPoints;

    %point = rand([1,13]) * 1e-9;


    %[simplex, distances, obsSet] = findSimplex(obsSet, point);
    %%
%     [nearestIndices,nearestDistances] = IDWInterpolation(obsSet,point);
% 
%     parameterPoints = parameterSet(nearestIndices,:);
% 
%     weights = 1 ./ nearestDistances.^2;
%     
%     onLattice = isinf(weights);
%     
%     if sum(onLattice) > 0
%         [~,idx] = max(weights);
%         interpolatedPoint = parameterPoints(idx,:)'
%     else
%         weights = weights / sum(weights);
%         interpolatedPoint = sum(weights .* parameterPoints);
%     end


    closestPoints = knnsearch(flip(sort(obsSet(:,end))),point.',"k",5);

    interpolatedPoint = mean(parameterSet(closestPoints,:));


end