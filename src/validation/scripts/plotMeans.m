function plotMeans(validationStruct)
    % This function plots the mean of the error distributions for each lattice.
    % It generates subplots, one per lattice type.

    
    % Get fieldnames (dataset names)
    names = fieldnames(validationStruct);
    
    % Number of datasets (subplots)
    numDatasets = numel(names);

    latticeNames = {'Gridlike', 'Gradient', 'Random', 'C&C'};
    
    % Loop through each dataset (each name)
    for i = 1:numDatasets
        % Extract the error matrix for the current dataset
        err = validationStruct.(names{i}).err;
        
        % Get number of lattices
        numLattices = size(err, 3);
        
        % Create a subplot for each dataset
        figure        
        hold on;

        k = 1;
        % Loop through each lattice type and plot
        for lattice = 1:numLattices
            % --- Plot: Normal Distribution ---
            subplot(2,4,k)
            % Calculate the mean and std across cycles (4th dimension) for this lattice
            meanInterps = mean(err(:, 2, lattice, :), 4, 'omitnan');
            meanErr = mean(meanInterps,2);
            stdErr = std(meanInterps,0,2,'omitnan');
            
            % Create the normal distribution based on mean and std
            x = linspace(min(meanErr), max(meanErr), 100);  % Define x values for the normal distribution
            y = normpdf(x, mean(meanErr), mean(stdErr));    % Compute the normal distribution (pdf)
            
            hist(gca,meanErr,100);

            set(gca,'view',[-90 90])
            xticks = get(gca, 'XTick');  % Get the current x-ticks
            set(gca, 'XTickLabel', abs(xticks));  % Set the x-tick labels to their absolute values
            xlim([0,10])
            ylabel('Amplitude');
            xlabel('Mean Error');


            k = k + 1;

            % --- Plot: Mean Error Across Points ---
            subplot(2,4,k)

            % Plot the mean error for the current lattice
            plot(meanErr, 'DisplayName', sprintf(latticeNames{lattice}));
            xlabel('Points');
            ylabel('Mean Error');
            ylim([0,10])
            legend('show');

            k = k + 1;

        end

        
        % Make y-axis shared across all subplots
        % linkaxes(findall(gcf, 'Type', 'Axes'), 'y');

        

        hold off;
    end


end
