function sampled_coords = generateGradientPoints_validation_2(nPoints,ylims,dimensions,rate)

    arguments
        nPoints = 3
        ylims = [0.1,1]
        dimensions = 2
        rate = 2
    end

    yLims = ylims;

    %dimensions = length(yLims);

    sampled_coords = (yLims(1) + (yLims(2)-yLims(1))*linspace(0,1,nPoints).^exp(rate));

    if dimensions == 1
        sampled_coords = sampled_coords;
    elseif dimensions == 2
        sampled_coords = cartesian(sampled_coords, sampled_coords);
    elseif dimensions == 3
        sampled_coords = cartesian(sampled_coords, sampled_coords,sampled_coords);
    elseif dimensions == 4
        sampled_coords = cartesian(sampled_coords, sampled_coords, sampled_coords, sampled_coords);
    end

end
