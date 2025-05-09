function MBLLInterpolation()
%MBLLINTERPOLATION Summary of this function goes here
%   Detailed explanation goes here


    testPoints = load(['..' filesep 'output' filesep 'interpolationTestPoints.mat']);
    testPoints = testPoints.testPoints;
    testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_interpolationTest.mat']);
    testSyntheticData = testSyntheticData.syntheticData;

    obsSet = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obsSet = obsSet.syntheticData;

    opticalProperties = loadOpticalProperties;
    opticalProperties = opticalProperties(:,2:5);

    % opticalProperties = opticalProperties(91:end,:);
    % testSyntheticData = testSyntheticData(:,91:end);


    attenuation = -log10(testSyntheticData(:,91:end) ./ mean(testSyntheticData(:,91:end)));

    pathlength = 25; %mm

    interpolated_values_MBLL = zeros([50,4]);

    for i = 1:height(attenuation)
        conc = pinv(pathlength * opticalProperties(91:end,:)) * (attenuation(i,:).');
        interpolated_values_MBLL(i,:) = conc;
    end

    %%

    names = {'O2Hb','HHb','WF','FF','mus'};

    figure
    for i = 1:4
        subplot(2, 2, i);
        hold on;
        plot(interpolated_values_MBLL(:,i));
        plot(testPoints(:,i));
        title(names{i})
    end


%%

    parameterSet = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameterSet = parameterSet.regionProperties;

    obsSet = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obsSet = obsSet.syntheticData;

    %testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_interpolationTest.mat']);
    %testSyntheticData = testSyntheticData.syntheticData;


    %step_points = {1:5:211; 1:2:211; 1:3:211; 1:3:211; 1:5:211};
    step_points = {1:1:211; 1:1:211; 1:1:211; 1:1:211; 1:1:211};

    F = generateRBFs(parameterSet,obsSet,step_points);

    interpolated_values = zeros([50,5]);

    for i = 1:height(testSyntheticData)
        interpolated_values(i,:) = multivariateInterpolation(F,testSyntheticData(i,:),step_points);
    end



    baselines = [3.2e-5,2.2e-5,.22,.22];
    names = {'O2Hb','HHb','WF','FF','mus'};
    ylabels = {'M','M','%','%'};

    figure
    for i = 1:4
        subplot(2, 2, i);
        hold on;
        plot(interpolated_values_MBLL(:,i));
        plot(interpolated_values(:,i) - baselines(i));
        plot(testPoints(:,i) - baselines(i));
        title(names{i})
        ylabel(ylabels{i})
    end


%%
    
    testPoints = load(['..' filesep 'output' filesep 'crossTalkTestPoints.mat']);
    testPoints = testPoints.testPoints;
    testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_crossTalkTest.mat']);
    testSyntheticData = testSyntheticData.syntheticData;

    
    %%


    attenuation = -log10(testSyntheticData(:,91:end) ./ mean(testSyntheticData(:,91:end)));

    pathlength = 25; %mm

    interpolated_values_MBLL = zeros([height(testSyntheticData),4]);

    for i = 1:height(attenuation)
        conc = pinv(pathlength * opticalProperties(91:end,:)) * (attenuation(i,:).');
        interpolated_values_MBLL(i,:) = conc;
    end


    F = generateRBFs(parameterSet,obsSet,step_points);

    interpolated_values = zeros([height(testSyntheticData),5]);

    for i = 1:height(testSyntheticData)
        interpolated_values(i,:) = multivariateInterpolation(F,testSyntheticData(i,:),step_points);
    end


    baselines = [3.2e-5,2.2e-5,.22,.22];
    names = {'O2Hb','HHb','WF','FF','mus'};
    ylabels = {'M','M','%','%','mm^-1'};

    sets = {'MBLL', 'CM', 'True'};
    figure
    t = tiledlayout(2,2);
    for i = 1:4
        %subplot(2, 2, i);
        nexttile;
        hold on;
        plot(interpolated_values_MBLL(:,i));
        plot(interpolated_values(:,i) - baselines(i));
        plot(testPoints(:,i) - baselines(i));
        title(names{i})
        ylabel(ylabels{i})
        legend(sets)
    end
    %xlabel(t, 'Time (s)','FontSize',20)



end