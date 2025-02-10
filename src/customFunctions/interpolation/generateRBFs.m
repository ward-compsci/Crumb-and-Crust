function F = generateRBFs(parameterSet,obs_set,step_points)

    F = cell([5,1]);


    for i = 1:5
        F{i} = rbfcreate(obs_set(:,step_points{i})',parameterSet(:,i)','RBFFunction','linear');
%         F{i} = rbfcreate(obs_set(:,step_points{i})',parameterSet(:,i)');
    end




end

