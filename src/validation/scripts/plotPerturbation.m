function plotPerturbationGrouped(allResults, perts, pointCounts)
    numPoints = numel(pointCounts);
    numDesigns = 4;
    numPerturbations = numel(perts);

    % Design labels and styles (in the order: Grid, Gradient, Random, CrustCrumb)
    designOrder = [1 2 3 4];  % map to dim 2 of err
    designNames = {'Grid-like', 'Gradient', 'Random', 'Crust & Crumb'};
    lineStyles = {'-.', '--', ':', '-'};
    colors = lines(4);  % default MATLAB color set (returns 7x3 RGB)

    figure;
    tiledlayout(2, 2);  % 2x2 layout for 4 point counts

    for pIdx = 1:numPoints
        results = allResults{pIdx};
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

        nexttile;
        hold on;
        for d = 1:numDesigns
            errorbar(perts, meanErrors(d, :), stdErrors(d, :), ...
                'LineStyle', lineStyles{d}, ...
                'Color', colors(d, :), ...
                'DisplayName', designNames{d}, ...
                'Marker', 'o');
        end
        hold off;
        title([num2str(pointCounts(pIdx)) ' RBF Points']);
        xlabel('Perturbation');
        ylabel('Mean error');
        grid on;
        legend('Location', 'best');
    end

    %sgtitle('Error vs Perturbation for Each RBF Point Count');
end
