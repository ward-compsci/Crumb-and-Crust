function validation = comparison_rbf_subsampling(ylims,npoints,dimensions,perturbation,method,cycles,test_points,subsample_frac)
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
        subsample_frac = 1.0
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

    % y_true = yLims(1) + (yLims(2)-yLims(1))*rand(target_length,dimensions);
    
    base = .75 + (1.25-.75) * rand;
    base = exp(base);

    base = exp(1);

    if dimensions == 1
        x_true = -log(y_true) / log(base);
    else
        x_true = generateXValues_2(y_true,base);
    end
        % x_true = generateXValues_2(y_true);

    validation.y = y;
    validation.yLims = yLims;

    validation.err = ones([length(y_true),4,cycles]);
    

    for cycle = 1:cycles
        counter = cycle;

        % y_fullSet = yLims(1) + (yLims(2)-yLims(1))*rand(target_length,dimensions);
        pert = ((-1).^randi(2, dimensions, length(y_true)) * perturbation).';
        if dimensions == 1
            y_fullSet = y_true + pert';
        else
            y_fullSet = y_true + pert;
        end

        yBrute = generateBruteForcePoints_validation(nPoints,yLims,dimensions);
        yGradient = generateGradientPoints_validation_2(nPoints,yLims,dimensions,1);
        yCrustCrumb = generateCrustCrumbPoints_validation_2(nPoints,yLims,dimensions,1);
        yRandom = generateRandomPoints_validation(nPoints,yLims,dimensions);

        if mod(cycle,50)==1
            disp(['Cycle ' num2str(counter)])
            disp(['Number of points - Brute: ' num2str(numel(yBrute)/dimensions), ' / Gradient: ' num2str(numel(yGradient)/dimensions)...
                ' / yCrustCrumb: ' num2str(numel(yCrustCrumb)/dimensions) ' / yRandom: ' num2str(numel(yRandom)/dimensions)])
        end

        % Define a helper function (or just inline code)
        subsample = @(data, frac) data(randperm(size(data,1), round(frac * size(data,1))), :);
        
        % Apply to each sampling method
        yBrute_sub = subsample(yBrute, subsample_frac);
        yGradient_sub = subsample(yGradient, subsample_frac);
        yCrustCrumb_sub = subsample(yCrustCrumb, subsample_frac);
        yRandom_sub = subsample(yRandom, subsample_frac);

        xBrute = generateXValues_2(yBrute_sub,base);
        xGradient = generateXValues_2(yGradient_sub,base);
        xCrustCrumb = generateXValues_2(yCrustCrumb_sub,base);
        xRandom = generateXValues_2(yRandom_sub,base);

        %.err takes the form (point:lattice:cycle)
        validation.err(:,1,cycle) = errorMethods(x_true,interpolationMethods(yBrute_sub,xBrute,y_fullSet,'RBF'),method);
        validation.err(:,2,cycle) = errorMethods(x_true,interpolationMethods(yGradient_sub,xGradient,y_fullSet,'RBF'),method);
        validation.err(:,3,cycle) = errorMethods(x_true,interpolationMethods(yRandom_sub,xRandom,y_fullSet,'RBF'),method);
        validation.err(:,4,cycle) = errorMethods(x_true,interpolationMethods(yCrustCrumb_sub,xCrustCrumb,y_fullSet,'RBF'),method);


    end


end

