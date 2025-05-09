function plotsubsampling(results, perts)
    numDesigns = 4;
    numPerturbations = numel(perts);

    % Design labels and styles (in the order: Grid, Gradient, Random, CrustCrumb)
    designOrder = [1 2 3 4];  % map to dim 2 of err
    designNames = {'Grid-like', 'Gradient', 'Random', 'Crust & Crumb'};
    lineStyles = {'-.', '--', ':', '-'};
    colors = lines(4);  % default MATLAB color set (returns 7x3 RGB)

    figure;
    tiledlayout(2, 1);  % 2x2 layout for 4 point counts

    fieldNames = fieldnames(results);
    meanErrors = zeros(numDesigns, numPerturbations);
    stdErrors = zeros(numDesigns, numPerturbations);

    for i = 1:numPerturbations
        err = results.(fieldNames{i}).err;  % 100 x 4 x 50
        err = squeeze(err);  % 100 x 4 x 50

        for d = 1:numDesigns
            designIdx = designOrder(d);
            designErr = squeeze(err(:, designIdx, :));  % 100 x 50
            cycleMeans = mean(designErr, 1);            % 1 x 50
            meanErrors(d, i) = mean(cycleMeans);
            stdErrors(d, i) = std(cycleMeans);
        end
    end

    jitter = linspace(-0.005,0.005,4);

    nexttile;
    hold on;
    for d = 1:numDesigns
        errorbar(perts+jitter(d), meanErrors(d, :), stdErrors(d, :), ...
            'LineStyle', lineStyles{d}, ...
            'Color', colors(d, :), ...
            'DisplayName', designNames{d}, ...
            'Marker', 'o');
    end
    hold off;
    title([num2str(1) ' RBF Points']);
    xlabel('Perturbation');
    ylabel('Mean error');
    grid on;
    legend('Location', 'best');


    % === Bar chart of std ===
    nexttile;
    bar(perts, stdErrors', 'grouped');  % Transpose so each group is a perturbation
    title('Variance of Error per Subsampling Level');
    xlabel('Perturbation');
    ylabel('Variance of Error');
    legend(designNames, 'Location', 'best');
    grid on;

end
