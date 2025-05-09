function rbf_results = plotVaryingPoints(samplingTable)
%PLOTERRORSTD Summary of this function goes here
%   Detailed explanation goes here

    dimensions = unique(samplingTable.Dimension);
    lattices = unique(samplingTable.Lattice); % Get unique lattice types
    samplingNums = unique(samplingTable.Sampling); % Get unique sampling numbers


    % Initialize a results table
    rbf_results = table([], [], [], [], [], 'VariableNames', {'Dimension', 'Lattice', 'Sampling', 'MeanError', 'StdError'});
    
    % Loop over each lattice
    for d = 1:length(dimensions)
        dimension = dimensions(d);
        for i = 1:length(lattices)
            lattice = lattices{i}; % Current lattice type
        
            % Loop over each sampling number
            for j = 1:length(samplingNums)
                samplingNum = samplingNums(j); % Current sampling number
        
                % Filter rows for the current lattice, sampling number, and "RBF" interpolation
                rows = samplingTable.Dimension == dimension & ...
                    strcmp(samplingTable.Lattice, lattice) & ...
                       samplingTable.Sampling == samplingNum & ...
                       strcmp(samplingTable.Interpolation, "RBF");

                % rows = strcmp(samplingTable.Lattice, lattice) & ...
                %        samplingTable.Sampling == samplingNum & ...
                %        strcmp(samplingTable.Interpolation, "RBF");

                % Get the errors for the filtered rows
                errors = samplingTable.Error(rows);
        
                % If there are no rows, skip this iteration
                if isempty(errors)
                    continue;
                end
        
                % Compute the mean and standard deviation of the error
                meanError = mean(errors);
                stdError = std(errors);
        
                % Append the results to the results table
                rbf_results = [rbf_results; {dimension, lattice, samplingNum, meanError, stdError}];
            end
        end
    end

    lineStyles = {'-', '--', ':', '-.'}; % Line styles for each lattice
    colors = lines(4); % Color palette for up to 4 lattices (adjust if needed)

    % Font sizes for labels and title
    labelFontSize = 40;
    titleFontSize = 50;

    for dim = 2

        % Create the figure
        tlo = figure;
    
        % Loop through lattices
        lattices = unique(rbf_results.Lattice); % Extract unique lattice names
        for i = 1:length(lattices)
            lattice = lattices{i}; % Current lattice
    
            % Filter data for this lattice
            latticeData = rbf_results(strcmp(rbf_results.Lattice, lattice) & rbf_results.Dimension == dim,:);
            % latticeData = rbf_results(strcmp(rbf_results.Lattice, lattice),:);

            % Extract sampling points, mean errors, and standard deviations
            samplingPoints = latticeData.Sampling;
            meanErrors = latticeData.MeanError;
            stdErrors = latticeData.StdError;
            disp(stdErrors)
    
            % Plot with error bars
            d = errorbar(samplingPoints, meanErrors, stdErrors, lineStyles{i}, 'LineWidth', 3);
            d.Color = colors(i, :); % Assign color to the line
            d.Bar.LineStyle = d.Line.LineStyle; % Match error bar style with line
            ylim([0 .15])
            hold on;
        end
    
        legend(lattices, 'Location', 'best'); % Use lattice names in the legend
        
        % Customize axes
        xticks([3,4,5,6,7]);
        xlabel('Sampling Points', 'FontSize', labelFontSize);
        ylabel('Absolute Error', 'FontSize', labelFontSize);
        set(findall(tlo, 'Type', 'Axes'), 'FontSize', labelFontSize);
        set(gca, 'YScale', 'log');
    
    end

end

