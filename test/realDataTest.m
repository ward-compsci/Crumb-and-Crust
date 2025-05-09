function realDataTest
%HAEMODYNAMICSTEST Summary of this function goes here
%   Detailed explanation goes here



    optical_properties = loadOpticalProperties;
    optical_properties = optical_properties(:,2:5);
    %optical_properties = optical_properties(91:end,:);


    temp = load("armCuff.csv");

    wavelengths = 690:1:900;
    original_wavelengths = temp(2:end,1);

    darkReading = temp(2:end,2:11);
    data = temp(2:end,12:end-10);

    data_denoised = data - mean(darkReading,2);
    
    real_data_full = interp1(temp(2:end,1),data_denoised,690:1:900,'spline').';

    % real_data = interp1(temp(2:end,1),data_denoised,wavelengths,'spline').';

    real_data = real_data_full;

    attenuation = -log10(real_data ./ real_data(1,:));

    pathlength = 25;
    interpolated_values_MBLL = zeros([height(real_data),4]);

    for i = 1:height(real_data)
        conc = pinv(pathlength * optical_properties) * (attenuation(i,:).');
        interpolated_values_MBLL(i,:) = conc;
    end

    figure
    for i = 1:4
        subplot(2, 2, i);
        hold on;
        plot(interpolated_values_MBLL(:,i));
    end

%% Phantom calibration

    full_wavelengths = 690:1:900.';

% Phantom1: 690nm , 0.141mua , 5.22mus
%           830nm , 0.140mua , 4.72mus (cm^-1 ???)
    phantom1 = load("phantom1.csv");
    phantom1_darkReading = phantom1(2:end,2:11);
    phantom1_data = phantom1(2:end,12:end-10);
    phantom1_denoised = phantom1_data - mean(phantom1_darkReading,2);
    phantom1_interp = interp1(original_wavelengths,phantom1_denoised,full_wavelengths,'spline').';

% Phantom2: 690nm , 0.105mua , 10.9mus
%           830nm , 0.102mua , 9.7mus (cm^-1 ???)
    phantom2 = load("phantom2.csv");
    phantom2_darkReading = phantom2(2:end,2:11);
    phantom2_data = phantom2(2:end,12:end-10);
    phantom2_denoised = phantom2_data - mean(phantom2_darkReading,2);
    phantom2_interp = interp1(original_wavelengths,phantom2_denoised,full_wavelengths,'spline').';

    phantom1_690nm = mean(phantom1_interp(:,1));
    phantom2_690nm = mean(phantom2_interp(:,1));
    phantom1_830nm = mean(phantom1_interp(:,141));
    phantom2_830nm = mean(phantom2_interp(:,141));

%

    parameter_set = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameter_set = parameter_set.regionProperties;

    mua_array = muaCalculation(parameter_set);
    mua_array_690nm = mua_array(:,1);
    mua_array_830nm = mua_array(:,141);

    % properties_array_comparison = [mua_array_690nm,parameter_set(:,5)];

    properties_array_comparison_690nm = [mua_array_690nm,parameter_set(:,5)];
    properties_array_comparison_830nm = [mua_array_690nm,parameter_set(:,5)];

    phantom_comparison = [0.0141,0.522;0.0140,0.472;0.0105,0.109;0.0102,0.970];
    

    min_indexes = zeros([1,4]);
    closest_combinations = zeros([4,2]);

    for i = 1:4

        if mod(i,2) == 1
            properties_array_comparison = properties_array_comparison_690nm;
        else
            properties_array_comparison = properties_array_comparison_830nm;
        end

        distances = sqrt(sum((properties_array_comparison - phantom_comparison(i,:)).^2, 2));
        
        % Find the index of the minimum distance
        [~, min_index] = min(distances);
        min_indexes(i) = min_index;

        % Find the closest combination
        closest_combination = properties_array_comparison(min_index, :);
        closest_combinations(i,:) = closest_combination;
    end


    obs_set = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    obs_set = obs_set.syntheticData;

    phantom1_690nm_match = obs_set(min_indexes(1),1);
    phantom2_690nm_match = obs_set(min_indexes(3),1);

    phantom1_830nm_match = obs_set(min_indexes(2),141);
    phantom2_830nm_match = obs_set(min_indexes(4),141);

%
    
    calibration_factor_phantom1_690nm = phantom1_690nm_match / phantom1_690nm;
    calibration_factor_phantom2_690nm = phantom2_690nm_match / phantom2_690nm;

    calibration_factor_phantom1_830nm = phantom1_830nm_match / phantom1_830nm;
    calibration_factor_phantom2_830nm = phantom2_830nm_match / phantom2_830nm;

    
    calibration_factor = interp1([690,830],[mean([calibration_factor_phantom1_690nm]), ...
        mean([calibration_factor_phantom1_830nm,calibration_factor_phantom2_830nm])],full_wavelengths,'linear','extrap');

    figure
    hold on;
    scatter([690,830,690,830],[calibration_factor_phantom1_690nm,calibration_factor_phantom1_830nm,calibration_factor_phantom2_690nm,calibration_factor_phantom2_830nm]);
    %scatter([690,830,830],[calibration_factor_phantom1_690nm,calibration_factor_phantom1_830nm,calibration_factor_phantom2_830nm]);
    plot(full_wavelengths,calibration_factor);

%

    real_data_calibrated = real_data_full .* calibration_factor;
    %real_data_calibrated = real_data_full .* calibration_factor_phantom1_690nm;
    % real_data_calibrated = real_data_full * mean([calibration_factor_phantom1_690nm,calibration_factor_phantom2_690nm,calibration_factor_phantom1_830nm,calibration_factor_phantom2_830nm]);

%%


    % obs_set = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
    % obs_set = obs_set.syntheticData;
    parameter_set = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    parameter_set = parameter_set.regionProperties;


    step_points = {1:30:211; 1:20:211; 1:20:211; 1:20:211; 1:20:211};

    F = generateRBFs(parameter_set,obs_set,step_points);


    interpolated_values = zeros([180,5]);

    for i = 1:180
        interpolated_values(i,:) = multivariateInterpolation(F,sgolayfilt(real_data_calibrated(i,:),3,11),step_points);
    end

    names = {'O2Hb','HHb'};
    figure
    t = tiledlayout(2,2);
    for i = 1:2
        %subplot(2,2,i);
        nexttile, plot(interpolated_values_MBLL(:,i))
        title(names{i})
    end
    for i = 3:4
        %subplot(2,2,i);
        nexttile, plot(interpolated_values(:,i-2))
    end

    %xlabel(t, 'Time (s)','FontSize',20)
    %ylabel(t, 'Concentration (μM)','FontSize',20)


    subsamples_list = 992:1000:3992;
    
    figure;
    t = tiledlayout(length(subsamples_list),2);

    for k = 1:length(subsamples_list)
        % Rows to keep (e.g., 1000)
        n_samples = subsamples_list(k);
        
        % Generate random indices without replacement
        idx = randperm(size(obs_set, 1), n_samples);
        
        % Undersample both datasets using the same indices
        obs_set_sub = obs_set(idx, :);
        parameter_set_sub = parameter_set(idx, :);
    
        F = generateRBFs(parameter_set_sub,obs_set_sub,step_points);
    
        interpolated_values = zeros([180,5]);
    
        for i = 1:180
            interpolated_values(i,:) = multivariateInterpolation(F,sgolayfilt(real_data_calibrated(i,:),3,11),step_points);
        end
    
        names = {'O2Hb','HHb'};
        for i = 1:2
            %subplot(2,2,i);
            nexttile, plot(interpolated_values(:,i))
            if k < 2
                title(names{i})
            end
        end
    end


    % Normalize obs_set and real_data_calibrated to unit variance
    mu = mean(obs_set, 1);
    sigma = std(obs_set, [], 1);
    obs_norm = (obs_set - mu) ./ sigma;
    real_norm = (real_data_calibrated - mu) ./ sigma;
    
    % Use knnsearch to find nearest neighbors
    idx = knnsearch(obs_norm, real_norm); % Each row in real_norm gets closest row in obs_norm
    
    % Retrieve corresponding parameter vectors
    estimated_params = parameter_set(idx, :); % [180 x 5]

    figure;
    t = tiledlayout(2,3)
    for i=1:5
        nexttile;
        plot(estimated_params(:,i));
    end


    

end

