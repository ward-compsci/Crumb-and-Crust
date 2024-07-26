function F = generateRBFs(parameterSet,obsSet,step_points)

    F = cell([5,1]);

%     step_points = {1:5:60; 1:10:121; 1:3:121; 1:3:121; 1:3:121};

    for i = 1:5
        F{i} = rbfcreate(obsSet(:,step_points{i})',parameterSet(:,i)','RBFFunction','cubic');
    end

end

