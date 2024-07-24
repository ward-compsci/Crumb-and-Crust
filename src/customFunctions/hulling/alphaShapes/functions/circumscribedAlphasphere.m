function centres = circumscribedAlphasphere(points,alpha)
% CIRCUMSCRIBEDALPHASPHERE Finds the centers of hyperspheres of given radius passing through given points
%   
%   CENTRES = CIRCUMSCRIBEDALPHASPHERE(POINTS, ALPHA) returns the coordinates of the centers
%   of circles with radius ALPHA that pass through each point in POINTS. The function
%   handles points in any number of dimensions.
%
%   INPUTS:
%       POINTS - A matrix where each row represents a point in an N-dimensional space.
%              For example, a 2D point set might be [x1, y1; x2, y2; ...].
%       ALPHA  - A scalar value representing the radius of the circles.
%
%   OUTPUT:
%       CENTRES - A matrix where each row represents the coordinates of a circle's center.
%               The number of rows corresponds to the number of solutions found.
%
%   EXAMPLE:
%       points = [1,1; 2,2];
%       alpha = 1;
%       centres = circumscribedAlphasphere(points, alpha);
%       disp('Centers:')
%       disp(centres)
%
%   See also: CIRCUMSCRIBEDHYPERSPHERE
%
% Author: Robert Ward
% Date: 22/05/2024
%
% https://www.geometrictools.com/Documentation/CentersOfSimplex.pdf

    A = points;
    b = ones([length(points),1]);

    coeffs = pinv(A) * b;
    %coeffs = A \ b;

    vecLength = sqrt(sum(coeffs.^2));
    coeffs = coeffs / vecLength;

    [c,r] = circumscribedHypersphere(points);

    dist = sqrt(alpha^2 - r^2);

    centres = [c + coeffs.' * dist; c - coeffs.' * dist];


end