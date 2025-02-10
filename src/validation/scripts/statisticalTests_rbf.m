function samplingTable = statisticalTests(varargin)
    % This function performs a statistical comparison of the interpolation methods
    % across all datasets (e.g., points3, points4) combined together.
    
    
    temp = varargin{1};
    names = fieldnames(temp);
    pointsLen = length(names);
    cycles = temp.(names{1}).cycles;

    sz = [pointsLen*4*cycles*length(varargin) 5]; % Sampled points * lattices * cycles * dimensions
    varTypes = ["double","double","string","double","double"];
    varNames = ["Dimension","Sampling","Lattice","Cycle","Error"];
    samplingTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
    
    samplingDesigns = categorical({'Grid-like', 'Gradient', 'Random', 'Crust Crumb'});

    points = [3, 4, 5, 6, 7];

    idx = 1;

    %.err takes the form (point:interpMethod:lattice:cycle)

    for i = 1:length(varargin) % Dataset (2D / 3D) - 2
        for j = 1:pointsLen % Points per axis (3 / 4 / 5 / 6 / 7 / 8) - 6
            for l = 1:4 % sampling designs
                temp = varargin{i}.(names{j}).err(:,l,:);
                temp = mean(temp,1);
                temp = squeeze(temp).';
                for m = 1:cycles
                    samplingTable(idx,:) = {i+1,points(j),samplingDesigns(l),m,temp(1,m)};
                    idx = idx + 1;
                end
            end
        end
    end

    
   



    % Fit the model for RBF interpolation
    lme_rbf = fitlme(samplingTable, 'Error ~ Lattice + (1|Dimension) + (1|Dimension:Sampling)')
    % lme_rbf = fitlme(samplingTable, 'Error ~ Lattice + (1|Sampling) + (1|Sampling:Dimension)')

    % disp(lme_rbf.Coefficients);

    contrast = [0 -1 0 1]; % (Intercept, Gradient, Random, Crust Crumb)

    [p, F, df1, df2] = coefTest(lme_rbf, contrast);
    fprintf('Contrast Test Results: p = %.5f, F = %.3f, df1 = %d, df2 = %d\n', p, F, df1, df2);


    % Plotting mean and std for increasing points, averaged across dimensions
    figure;
    hold on;
    title('Mean and Std of Error Across Dimensions');
    xlabel('Points');
    ylabel('Error');
    
    lattices = unique(samplingTable.Lattice);

    for l = 1:length(lattices)
        lattice = lattices(l);
        subset = samplingTable(samplingTable.Lattice == lattice, :);
        means = groupsummary(subset, 'Sampling', {'mean', 'std'}, 'Error');

        % Extract data
        x = unique(samplingTable.Sampling);
        y = means.mean_Error;
        yerr = means.std_Error;

        % Plot with error bars
        errorbar(x, y, yerr, 'DisplayName', char(lattice), 'LineWidth', 1.5);
    end

    legend('Location', 'best');
    grid on;
    hold off;
end
