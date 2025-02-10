function monotinicityTest
%MONOTINICITYTEST Summary of this function goes here
%   Detailed explanation goes here


    parameter_set = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameter_set = parameter_set.regionProperties;
    
    obs_set = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obs_set = obs_set.syntheticData;


    monotonic_increasing = false(size(obs_set, 2), 1);
    monotonic_decreasing = false(size(obs_set, 2), 1);

    for col = 1:size(obs_set, 2)
        col_data = sort(obs_set(:, col));
        
        % Check for monotonic increase
        if all(diff(col_data) >= 0)
            monotonic_increasing(col) = true;
        end
        
        % Check for monotonic decrease
        if all(diff(col_data) <= 0)
            monotonic_decreasing(col) = true;
        end
    end

    % Display results
    for col = 1:size(obs_set, 2)
        if monotonic_increasing(col)
            fprintf('Column %d is monotonically increasing.\n', col);
        elseif monotonic_decreasing(col)
            fprintf('Column %d is monotonically decreasing.\n', col);
        else
            fprintf('Column %d is not monotonic.\n', col);
        end
    end

end

