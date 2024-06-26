function centres = circumscribedAlphasphere_outdated(points,alpha)
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
%   See also SOLVE, SYM.
%
% Author: Robert Ward
% Date: 22/05/2024
%
% https://www.geometrictools.com/Documentation/CentersOfSimplex.pdf


    n = size(points,2);

    c = sym('c', [1 n]);

    [~,r] = circumscribedHypersphere(points);

    if alpha < r
        warning(['alpha value too small, r = ' num2str(r)])
    end
        
 
    eqs = sum((c - points).^2, 2) == alpha^2;
    %eqs = sym(zeros(1,n));
    %for i = 1:n
    %    eqs(i) = sum((c - points(i,:)).^2) == alpha^2;
    %end

    sol = vpasolve(eqs, c);

    centres = zeros([2 n]);
    names = string(c);

    for i = 1:n
        centres(:,i) = sol.(names{i});
    end


end


