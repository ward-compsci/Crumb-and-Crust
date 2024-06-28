function boundaryPoints = extractBoundaryPoints(edges,dimensions)
    % Initialize an empty array to store boundary points
    boundaryPoints = [];
    
    % Iterate through each cell of the cell array
    for i = 1:numel(edges)
        % Extract the points from the current cell
        edge = edges{i};
        points = reshape(edge, [], dimensions); % Reshape to 2x2 matrix
        points = unique(points, 'rows'); % Extract unique points
        
        % Concatenate the unique points to the array of boundary points
        boundaryPoints = [boundaryPoints; points];
    end
    
    % Ensure uniqueness of boundary points
    boundaryPoints = unique(boundaryPoints, 'rows');
end