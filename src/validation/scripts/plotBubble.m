function plotBubble(allResults, bubbles, pointCounts)
    numConfigs = numel(pointCounts);
    figure;
    hold on;

    % Adjust depending on range of data
    jitter = linspace(0,0,4);

    for idx = 1:numConfigs
        numPts = pointCounts(idx);
        results = allResults{idx};
        fieldNames = fieldnames(results);
        numBubbles = numel(fieldNames);

        meanErrors = zeros(1, numBubbles);
        stdErrors = zeros(1, numBubbles);

        for j = 1:numBubbles
            err = results.(fieldNames{j}).err;  % 100x1xcycles
            err = squeeze(err);                 % 100xN
            if isvector(err)
                err = err(:);  % ensure column vector for 1 cycle case
            end
            cycleMeans = mean(err, 1);          % 1 x N (mean over test points)
            meanErrors(j) = mean(cycleMeans);   % mean across cycles
            stdErrors(j) = std(cycleMeans);     % std across cycles
        end

        %subplot(numConfigs, 1, idx);
        %subplot(1, 4, idx);
        errorbar(bubbles + jitter(idx), meanErrors, stdErrors, '-o', 'DisplayName', num2str(numPts));
        title([num2str(numPts) ' points']);
        xlabel('Bubble value');
        ylabel('Mean error');
        grid on;
    end

    legend('Location', 'best');

end