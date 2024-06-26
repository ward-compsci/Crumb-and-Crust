function delaunayTriangulation
%DELAUNAYTRIANGULATION Summary of this function goes here
%   Detailed explanation goes here

    points = rand([50,2]);
    [numPoints,n] = size(points);

    newDim = vecnorm(points,2,n).^2;
    
    newPoints = [points,newDim];

    for i = 1:numPoints
        convhulln(newPoints(i,:))
    end

end

