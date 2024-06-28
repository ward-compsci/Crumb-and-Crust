function [alphaShapePoints,alphaShapeIdx] = findAlphaShape(points,alpha)
%FINDALPHASHAPE_WARD Summary of this function goes here
%   Detailed explanation goes here
    
    arguments
        points
        alpha
    end

    tol = 10*eps;
    p = 2; %parameter for norm; 2 = euclidian

    n = size(points,2);
    simplexLength = n+1;

    tri = delaunayn(points);
    numSimplices = size(tri,1);

    save(['..' filesep 'output' filesep 'tri'], 'tri');


    alphaShapeIdx = cell(numSimplices,n+1);
    alphaShapePoints = cell(numSimplices,n+1);

    pool = gcp('nocreate');
    if isempty(pool)
        pool = parpool;
        poolCreated = true;
    else
        poolCreated = false;
    end

    parfor i = 1:length(tri)
        simplex = tri(i, :);
        simplex_points = points(simplex, :);

        for j = 1:simplexLength
            hyperface = simplex;
            hyperface_points = simplex_points;
            hyperface(j) = [];
            hyperface_points(j,:) = [];

            [c,r] = circumscribedHypersphere(hyperface_points);

            %alpha test
            if r < alpha
                
                centres = circumscribedAlphasphere(hyperface_points,alpha);

                if min(vecnorm(centres(1,:)-points,p,2)) >= alpha - tol | min(vecnorm(centres(2,:)-points,p,2)) >= alpha - tol
                    alphaShapeIdx{i,j} = hyperface;
                    alphaShapePoints{i,j} = hyperface_points;
                end
            end

        end
        

    end



    nonEmpty = ~cellfun('isempty',alphaShapePoints);
    alphaShapePoints = alphaShapePoints(nonEmpty);
    alphaShapeIdx = alphaShapeIdx(nonEmpty);


    if poolCreated
        delete(pool);
    end

end