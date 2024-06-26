function [C, r] = circumscribedHypersphere(points)
% CIRCUMSCRIBEDHYPERSPHERE Finds the center and radius of the sphere
% passing through given points where dim(points) = num(points)
%
%   [C, r] = CIRCUMSCRIBEDHYPERSPHERE(POINTS) returns the coordinates of the center C
%   and the radius r of the sphere that passes through the provided points.
%   The function handles points in any number of dimensions.
%
%   INPUT:
%       POINTS - A matrix where each row represents a point in an N-dimensional space.
%              At least three points are required for a unique sphere in 3D space.
%              For example, a 3D point set might be [x1, y1, z1; x2, y2, z2; x3, y3, z3].
%
%   OUTPUT:
%       C - A 1xN vector representing the coordinates of the sphere's center.
%       r - A scalar representing the radius of the sphere.
%
%   EXAMPLE:
%       points = [1,1,1; 2,3,2; 5,2,5];
%       [C, r] = find_sphere_center(points);
%       disp('Center:')
%       disp(C)
%       disp('Radius:')
%       disp(r)
%
%       See also PINV, SUM.
%
% Author: Robert Ward
% Date: 22/05/2024
%
% https://www.geometrictools.com/Documentation/CentersOfSimplex.pdf

    n = size(points,2);

 
    M = zeros(n, n);
    b = zeros(n, 1);

    for i = 1:n
        vi = points(i,:) - points(1,:);
        M(i,:) = vi;
        b(i) = 1/2 * sum(vi.^2);
    end

    %C = points(1,:) + (pinv(M) * b).';
    C = points(1,:) + (lsqminnorm(M,b)).';
    
    r = sqrt(sum((C - points(1,:)).^2));


end

