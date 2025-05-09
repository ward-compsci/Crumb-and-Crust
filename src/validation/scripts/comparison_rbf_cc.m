function validation = comparison_rbf_cc(ylims,npoints,dimensions,perturbation,method,cycles,test_points,bubble,totalPoints)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    arguments
        ylims = [0.01 1]
        npoints = 5
        dimensions = 2
        perturbation = 0
        method = 'abs'
        cycles = 1
        test_points=729
        bubble=0.0001
        totalPoints=npoints^dimensions
    end

    nPoints = npoints;
    yLims = ylims;

    validation.interpMethods = {'RBF'};
    validation.errorMethod = {method};
    validation.points = nPoints^dimensions;
    validation.dimensions = dimensions;
    validation.cycles = cycles;


    % target_length = 15625; % perfect square, perfect cube
    target_length = test_points; % perfect square, perfect cube

    if dimensions == 1
        y = linspace(yLims(1), yLims(2), target_length);
        y_true = y;
    elseif dimensions == 2
        y = linspace(yLims(1), yLims(2), round(sqrt(target_length)));
        y_true = cartesian(y,y);
    elseif dimensions == 3
        y = linspace(yLims(1), yLims(2), round(nthroot(target_length, 3)));
        y_true = cartesian(y,y,y);
    elseif dimensions == 4
        y = linspace(yLims(1), yLims(2), round(nthroot(target_length, 4)));
        y_true = cartesian(y,y,y,y);
    elseif dimensions == 5
        y = linspace(yLims(1), yLims(2), round(nthroot(target_length, 5)));
        y_true = cartesian(y,y,y,y,y);
    elseif dimensions == 6
        y = linspace(yLims(1), yLims(2), round(nthroot(target_length, 6)));
        y_true = cartesian(y,y,y,y,y,y);
    else
        disp('Input dimensions not supported')
    end

    base = exp(1);

    if dimensions == 1
        x_true = -log(y_true) / log(base);
    else
        x_true = generateXValues_2(y_true,base);
    end

    validation.y = y;
    validation.yLims = yLims;

    validation.err = ones([length(y_true),1,cycles]);
    

    for cycle = 1:cycles
        counter = cycle;

        % y_fullSet = yLims(1) + (yLims(2)-yLims(1))*rand(target_length,dimensions);
        pert = ((-1).^randi(2, dimensions, length(y_true)) * perturbation).';
        if dimensions == 1
            y_fullSet = y_true + pert';
        else
            y_fullSet = y_true + pert;
        end

        yCrustCrumb = generateCrustCrumbPoints_validation_2(nPoints,yLims,dimensions,1,bubble,totalPoints);

        xCrustCrumb = generateXValues_2(yCrustCrumb,base);

        %.err takes the form (point:lattice:cycle)
        validation.err(:,1,cycle) = errorMethods(x_true,interpolationMethods(yCrustCrumb,xCrustCrumb,y_fullSet,'RBF'),method);

        if mod(cycle,50)==1
            disp(['Cycle ' num2str(counter)])
            disp(['Number of points - Crust Crumb: ' num2str(numel(yCrustCrumb)/dimensions)])
        end


    end


end

