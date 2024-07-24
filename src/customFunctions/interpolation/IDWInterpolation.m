function [nearestIndices,nearestDistances] = IDWInterpolation(obsSet,point)


    [~,n] = size(obsSet);

    %distances = sqrt(sum((obsSet - point).^2, 2));

% 
    minVals = min(obsSet);
    maxVals = max(obsSet);
    normalizedPoints = (obsSet - minVals) ./ (maxVals - minVals);

    obsSet = normalizedPoints;

    mu = mean(obsSet);
    sigma = std(obsSet);
    standardizedData = (obsSet - mu) ./ sigma;

    % Perform PCA
    [coeff, score, ~, ~, ~, mu] = pca(standardizedData);

    % Transform the data to the PCA space
    transformedData = score; % The data projected onto the principal components

    standardizedNewPoint = (point - mu) ./ sigma;


    % Project the new point onto the PCA space
    transformedNewPoint = standardizedNewPoint * coeff;
    
    % Compute the covariance matrix and its inverse in the PCA space
    cov_matrix = cov(transformedData);
    inv_cov_matrix = inv(cov_matrix);



    % Calculate Mahalanobis distance for each point
    diffs = transformedData - transformedNewPoint; % 828x6 matrix, where each row is the difference to the new point

    distances = sqrt(sum((diffs * inv_cov_matrix) .* diffs, 2)); % 828x1 vector


    
    %distances = sqrt(sum((transformedData - transformedNewPoint).^2, 2));



    %distances = sqrt(sum((obsSet - point).^2, 2));

    [sortedDistances, sortedIndices] = sort(distances);


    nearestIndices = sortedIndices(1:n+1);
    
    simplex = obsSet(nearestIndices,:);

    nearestDistances = sortedDistances(1:n+1);


    % figure
    % hold on;
    % scatter(transformedData(:,1),transformedData(:,2));
    % scatter(transformedNewPoint(1),transformedNewPoint(2));


    nearestIndices = sortedIndices;
    nearestDistances = sortedDistances;

end