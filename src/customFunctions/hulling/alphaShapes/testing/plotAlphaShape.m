function plotAlphaShape(alphaShape,points)
% PLOTALPHASHAPE Visualizes 2D or 3D alpha shapes.
%
%   PLOTALPHASHAPE(POINTS, ALPHASHAPE) plots the points and the corresponding 
%   alpha shapes in 2D or 3D space.
%
%   Inputs:
%       - POINTS: A Nx2 or Nx3 matrix containing the coordinates of the points.
%                 Each row represents a point in 2D or 3D space.
%       - ALPHASHAPE: A cell array where each cell contains a matrix representing 
%                     an n-1 simplex. Each matrix has dimensions 2x2 for 2D simplices 
%                     or 3x3 for 3D simplices.
%
%   The function determines the dimensionality of the points and alpha shapes 
%   and creates a scatter plot of the points. It then iterates through the 
%   alpha shapes to plot the edges (in 2D) or triangular faces (in 3D).
%
%   Example:
%       % Example data
%       points = [0 0; 1 0; 0 1; 1 1; 0.5 0.5];
%       alphaShape = {
%           [0 0; 1 0],
%           [0 1; 0 0],
%           [1 1; 1 0],
%           [0 1; 1 1],
%       };
%       plotAlphaShape(points, alphaShape);
%
%   See also SCATTER, SCATTER3, PATCH, PLOT.

    arguments
        alphaShape
        points = false
    end

    numElements = numel(alphaShape);
    dims = sqrt(numel(alphaShape{1}));
    
    figure;
    hold on

    if dims == 2
        if points ~= false
            scatter(points(:,1),points(:,2));
        end    
        
        for i = 1:numElements
            simplex = alphaShape{i};
            
            plot([simplex(1,1), simplex(2,1)], [simplex(1,2), simplex(2,2)], 'b-');
        end

    elseif dims == 3
        if points ~= false
            scatter3(points(:,1),points(:,2),points(:,3));
        end
        
        for i = 1:numel(alphaShape)
            simplex = alphaShape{i};
             
            patch('Vertices', simplex, 'Faces', [1 2 3], 'FaceAlpha',.3);           
        end

        view(3); % 3D view
    else
        warning(['dim not supported for visualisation (2D/3D)'])
    end

end

