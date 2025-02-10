function crossTalkTest()
%CROSSTALKTEST Summary of this function goes here
%   Detailed explanation goes here

%%
    regionLims = load(['..' filesep 'output' filesep 'regionAll_lims.txt']);
    numParams = length(regionLims);
    
    initialValues = ((regionLims(2,:) - regionLims(1,:)) * .2) + regionLims(1,:);
    increaseFactor = ((regionLims(2,:) - regionLims(1,:)) * .8) + regionLims(1,:);
    numSteps = 10;
    totalSteps = 2 * numSteps - 1; % because the peak value is counted twice
    crosstalkOffset = 5;
    totalPoints = totalSteps + crosstalkOffset * (numParams - 1);
    
    testPoints = repmat(initialValues, totalPoints, 1);
    
    for i = 1:numParams
        increase = linspace(initialValues(i), increaseFactor(i), numSteps);
        decrease = linspace(increaseFactor(i), initialValues(i), numSteps);
        increaseDecrease = [increase, decrease(2:end)];
        
        startIndex = (i - 1) * crosstalkOffset + 1;
        
        endIndex = startIndex + totalSteps - 1;
        testPoints(startIndex:endIndex, i) = increaseDecrease;
    end

    save(['..' filesep 'output' filesep 'crossTalkTestPoints'],"testPoints");



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

    step_points = {1:5:211; 1:2:211; 1:3:211; 1:3:211; 1:5:211};
    % obsSet = obsSet(:,91:end);
    % testSyntheticData = testSyntheticData(:,91:end);

    % step_points = {1:3:90; 1:3:121; 1:3:121; 1:3:121; 1:3:121};
    step_points = {1:40:211; 1:40:211; 1:40:211; 1:40:211; 1:40:211};


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

