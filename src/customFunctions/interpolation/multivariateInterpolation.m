function interpolatedPoint = multivariateInterpolation(F, point, step_points)

    interpolatedPoint = zeros([1,5]);

%     step_points = {1:5:60; 1:10:121; 1:3:121; 1:3:121; 1:3:121};


    for i = 1:5
%         F = rbfcreate(obsSet(:,step_points{i})',parameterSet(:,i)','RBFFunction','cubic');
        temp = rbfinterp(point(step_points{i})',F{i});
        interpolatedPoint(i) = temp.';
    end


end