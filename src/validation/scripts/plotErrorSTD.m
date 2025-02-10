function plotErrorSTD(rbf_results)
%PLOTERRORSTD Summary of this function goes here
%   Detailed explanation goes here


    % Specify the conditions to plot
    % dimensions = [2, 3]; % 2D and 3D
    dimensions = [2, 3]; % 2D and 3D
    points = [3, 4]; % 3 and 4 sampling points
    points = [3, 4, 5, 6, 7, 8];
    points = [3, 4, 5, 6];

    % Set up the tiled layout
    figure
    tlo = tiledlayout(length(dimensions), length(points), 'TileSpacing', 'Compact', 'Padding', 'Compact');
    
    % Font sizes
    labelFontSize = 20;
    titleFontSize = 25;
    
    % Loop through dimensions and points
    for dimIdx = 1:length(dimensions)
        for pointIdx = 1:length(points)
            % Current dimension and sampling points
            dim = dimensions(dimIdx);
            point = points(pointIdx);
            
            % Filter results for the current dimension and sampling points
            conditionRows = (rbf_results.Dimension == dim & rbf_results.Sampling == point);
            conditionData = rbf_results(conditionRows, :);
            
            % Extract mean errors, std errors, and lattice names
            meanErrors = conditionData.MeanError;
            stdErrors = conditionData.StdError;
            lattices = conditionData.Lattice;
    
            % Move to the next tile
            nexttile;
            
            % Create bar chart with error bars
            b = bar(meanErrors, 'FaceColor', 'flat');
            hold on;
            errorbar(1:length(meanErrors), meanErrors, stdErrors, '.k', 'LineWidth', 1.5);
    
            % Customize bar colors
            colormap(lines(length(meanErrors))); % Assign distinct colors to bars
            
            % Add labels, title, and grid
            xticks(1:length(meanErrors));
            xticklabels(lattices);
            xlabel('Lattice', 'FontSize', labelFontSize);
            ylabel('Error', 'FontSize', labelFontSize);
            title([num2str(dim) 'D, ' num2str(point) ' Points'], 'FontSize', titleFontSize);
            grid on;

            ylim([0 0.3])
        end
    end
    
    % Global customization
    set(findall(gcf, 'Type', 'Axes'), 'FontSize', labelFontSize);

    % 
    % %%
    % 
    % figure
    % 
    % b = bar(y, 'grouped');
    % hold on
    % % Calculate the number of groups and number of bars in each group
    % [ngroups,nbars] = size(y);
    % 
    % x = nan(nbars, ngroups);
    % for i = 1:nbars
    %     x(i,:) = b(i).XEndPoints;
    % end
    % 
    % errorbar(x',y,yErr,'k','linestyle','none','Color', 'k', 'LineWidth', 1);
    % hold off
    % 
    % 
    % 
    % % Set Axis properties
    % set(gca,'xticklabel',{'linear'; 'RBF'; 'natural'},'FontSize',20);
    % if legendOn == true
    %     legend('Grid-like', 'Gradient', 'Random', 'Crust Crumb')
    % end
    % 
    % ylabel('Error')
    % xlabel('Interpolation')
    % 
    % if titleOn == true
    %     titleText = [validationStruct.errorMethod{1} ' error for ' ...
    %         num2str(validationStruct.yLims(1)) ' < y < ' num2str(validationStruct.yLims(2))...
    %         ' in ' num2str(dimensions) ' dimensions - ' num2str(points) ' lattice points over '...
    %         num2str(cycles) ' cycles'];
    % 
    %     title(titleText,'FontWeight','normal')
    % end
    % 
    % if logScale == true
    %     set(gca, 'YScale', 'log')
    % end
    
    %ylim([0,0.37]);
    %text = [title ' ' num2str(y) '+/- ' num2str(yErr)]
    % disp('Mean')
    % disp(y)
    % disp('std')
    % disp(yErr)


    
end

