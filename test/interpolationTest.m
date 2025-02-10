function interpolationTest()
%INTERPOLATIONTEST Summary of this function goes here
%   Detailed explanation goes here
    

    regionLims = load(['..' filesep 'output' filesep 'regionAll_lims.txt']);
    numParams = length(regionLims);
    % Initial values for the parameters
    initialValues = ((regionLims(2,:) - regionLims(1,:)) * .2) + regionLims(1,:);
         
    % Define the increase factor (e.g., 3 for 200% increase)
    increaseFactor = ((regionLims(2,:) - regionLims(1,:)) * .8) + regionLims(1,:);
    
    % Define the number of steps for the increase and decrease
    numSteps = 10;


    %% don't change baseline or mus

    testPoints = repmat(initialValues, numSteps * (numParams), 1);

    for i = 1:numParams
        increase = linspace(initialValues(i), increaseFactor(i), numSteps);
        testPoints((numSteps*(i-1)+1):(numSteps*(i-1)+1)+numSteps-1, i) = increase;
    end

    save(['..' filesep 'output' filesep 'interpolationTestPoints'],"testPoints");

    %%

    filePath = ['..' filesep 'output' filesep 'syntheticData_interpolationTest.mat'];

    % Check if the file exists
    if ~exist(filePath, 'file')
        forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
        testSyntheticData = runForearmSimulations(forearmMesh,testPoints,'interpolationTest');
    else
        testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_interpolationTest.mat']);
        testSyntheticData = testSyntheticData.syntheticData;
    end


    %%
    obsSet = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obsSet = obsSet.syntheticData;
    parameterSet = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameterSet = parameterSet.regionProperties;

    % obsSet = obsSet(:,91:end);
    % testSyntheticData = testSyntheticData(:,91:end);
    % step_points = {1:3:90; 1:3:121; 1:3:121; 1:3:121; 1:3:121};

    step_points = {1:5:211; 1:2:211; 1:3:211; 1:3:211; 1:5:211};
    step_points = {1:40:211; 1:40:211; 1:40:211; 1:40:211; 1:40:211};

    
    F = generateRBFs(parameterSet,obsSet,step_points);

    for i = 1:height(testSyntheticData)
        interpolated_values(i,:) = multivariateInterpolation(F,testSyntheticData(i,:),step_points);
    end



% 
%     params = zeros([50,5]);
%     for i = 1:50
%         tempParams = zeros([121,5]);
%         for j = 1:121
%             [~,closest] = min(abs(obsSet(:,j) - testSyntheticData(i,j)));
%             tempParams(j,:) = parameterSet(closest,:);
%         end
%         params(i,:) = mean(tempParams);
%     end
% 
%     figure
%     for i = 1:numParams
%         subplot(2, 3, i);
%         hold on;
%         plot(params(:,i));
%         plot(testPoints(:,i));
%     end

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


    names = {'O2Hb','HHb','WF','FF','mus', 'melanin'};

    figure
    for i = 1:numParams
        subplot(2, 3, i);
        hold on;
        plot(corrected_values(:,i));
        plot(testPoints(:,i));
        title(names{i})
    end


end

