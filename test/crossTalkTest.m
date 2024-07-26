function crossTalkTest()
%CROSSTALKTEST Summary of this function goes here
%   Detailed explanation goes here

%%
    regionLims = load(['..' filesep 'output' filesep 'regionAll_lims.txt']);
    numParams = length(regionLims);
    
    % Initial values for the parameters
    initialValues = ((regionLims(2,:) - regionLims(1,:)) * .2) + regionLims(1,:);
    
    % Define the increase factor (e.g., 3 for 200% increase)
    increaseFactor = ((regionLims(2,:) - regionLims(1,:)) * .8) + regionLims(1,:);
    
    % Define the number of steps for the increase and decrease
    numSteps = 10;
    
    % Define the total number of points per parameter
    totalSteps = 2 * numSteps - 1; % because the peak value is counted twice
    
    % Number of points to start earlier for crosstalk
    crosstalkOffset = 5;
    
    % Calculate the total number of points considering the crosstalk
    totalPoints = totalSteps + crosstalkOffset * (numParams - 1);
    
    % Initialize the testPoints matrix
    testPoints = repmat(initialValues, totalPoints, 1);
    
    for i = 1:numParams
        % Generate the increase and decrease sequences
        increase = linspace(initialValues(i), increaseFactor(i), numSteps);
        decrease = linspace(increaseFactor(i), initialValues(i), numSteps);
        increaseDecrease = [increase, decrease(2:end)];
        
        % Calculate the starting index considering the crosstalk offset
        startIndex = (i - 1) * crosstalkOffset + 1;
        
        % Fill in the testPoints matrix
        endIndex = startIndex + totalSteps - 1;
        testPoints(startIndex:endIndex, i) = increaseDecrease;
    end


    figure
    for i = 1:numParams
        subplot(2, 3, i);
        hold on;
        plot(testPoints(:,i));
    end


%%
    filePath = ['..' filesep 'output' filesep 'syntheticData_crossTalkTest.mat'];

    % Check if the file exists
    if ~exist(filePath, 'file')
        forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
        testSyntheticData = runForearmSimulations(forearmMesh,testPoints,'crossTalkTest');
    else
        testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_crossTalkTest.mat']);
        testSyntheticData = testSyntheticData.syntheticData;
    end

%%
    obsSet = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obsSet = obsSet.syntheticData;
    parameterSet = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameterSet = parameterSet.regionProperties;

    parameterSet_original = parameterSet;
    testPoints_original = testPoints;

    obsSet_original = obsSet;
    testSyntheticData_original = testSyntheticData;

    step_points = {1:5:60; 1:10:121; 1:3:121; 1:3:121; 1:3:121};

    F = generateRBFs(parameterSet,obsSet,step_points);

    for i = 1:height(testSyntheticData_original)
        interpolated_values(i,:) = multivariateInterpolation(F,testSyntheticData(i,:),step_points);
    end

%%
    figure
    for i = 1:numParams
        subplot(2, 3, i);
        hold on;
        plot(interpolated_values(:,i));
        plot(testPoints(:,i));
    end


    corrected_values = interpolated_values;
    
    %Cut values beyond lookup table
    for j = 1:numParams
        max_value = max(parameterSet(:,j));
        min_value = min(parameterSet(:,j));
        
        for i = 2:height(testPoints)
            if corrected_values(i,j) > max_value
                corrected_values(i,j) = max_value;
            elseif corrected_values(i,j) < min_value
                corrected_values(i,j) = min_value;
            end
        end
    end

    for j = 1:numParams
%         threshold = max_value * percentage_threshold;
        threshold = 3 * std(corrected_values(:,j));

        for i = 2:height(testPoints)

            diff_value = interpolated_values(i,j) - interpolated_values(i-1,j);
            
            if abs(diff_value) > threshold
%                 corrected_values(i,j) = corrected_values(i-1,j) + sign(diff_value) * threshold;
%                 corrected_values(i,j) = corrected_values(i-1,j);
                try
                    corrected_values(i,j) = (corrected_values(i-1,j)+corrected_values(i+1,j)) / 2;
                catch
                    corrected_values(i,j) = corrected_values(i,j);
                end
            end
        end
    end


    names = {'O2Hb','HHb','WF','FF','mus'};

    figure
    for i = 1:numParams
        subplot(2, 3, i);
        hold on;
        plot(corrected_values(:,i));
        plot(testPoints(:,i));
        title(names{i})
    end


end

