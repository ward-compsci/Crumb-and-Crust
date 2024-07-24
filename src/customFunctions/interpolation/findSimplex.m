function [containingSimplex,simplexDistances,point] = findSimplex(obsSet, point)

    %testPoint = ones([1,121]) * 1e-8;

    [~,n] = size(obsSet);

    distances = sqrt(sum((obsSet - point).^2, 2));
    
    [sortedDistances, sortedIndices] = sort(distances);

    simplexFound = false;
    k = n;

    while simplexFound ~= true && k < length(obsSet)
    %for k = n+1:length(obsSet)
        k = k+1;
        % Select the k nearest points
        nearestIndices = sortedIndices(1:k);
        nearestPoints = obsSet(nearestIndices, :);
    
        %Find vertex combinations
        combs = nchoosek(1:k,n+1);
        [numSimplexes,~] = size(combs);

        for i = 1:numSimplexes
            simplexIndices = sortedIndices(combs(i,:),:);
            simplex = obsSet(simplexIndices,:);
            simplexDistances = sortedDistances(combs(i,:));

            A = simplex(2:end, :)' - simplex(1, :)';
            b = point' - simplex(1, :)';
            %lambda = A \ b;
            lambda = pinv(A) * b;
            lambda0 = 1 - sum(lambda);
            barycentricCoords = [lambda0; lambda];

                    % Check if all barycentric coordinates are non-negative and sum to 1
            if all(barycentricCoords >= 0) && abs(sum(barycentricCoords) - 1) < 1e-10
                simplexFound = true;
                containingSimplex = simplex;
                break;
            end
        end
    end

    if simplexFound == false
        % Point is outside the convex hull, replace it with the bisection of the two closest points
        closestPoints = obsSet(sortedIndices(1:n), :);
        midpoint = mean(closestPoints, 1);
    
        % Take the next closest point to form a simplex
        nextClosestPoint = obsSet(sortedIndices(n+1), :);
        containingSimplex = [closestPoints; nextClosestPoint];
        point = midpoint;

        simplexDistances = sqrt(sum((containingSimplex - point).^2, 2));

    end

end

