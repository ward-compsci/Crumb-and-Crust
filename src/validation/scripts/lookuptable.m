clc; clear; close all;

% Define grid points
x1 = linspace(0,1,10);
x2 = linspace(0,1,10);

y = zeros(100,2);
X = zeros(100,2); % Store original grid for left plot
k = 1;

for i = 1:length(x1)
    for j = 1:length(x2)
        mua = x1(i) .* [.7, .5] + x2(j) .* [.3 .6];
        mus = [20 25];
        sigma = sqrt(3*mua .* (mua+mus));
        num = sinh(sigma./mus);
        denom = sinh(sigma.*2.5);
        
        % Transformation
        result = -log((num./denom) .* (1 / sqrt(2*pi))); 
        
        % Store values
        y(k,:) = result;
        X(k,:) = [x1(i), x2(j)]; % Store original grid
        k = k + 1;
    end
end

% Reshape `X` and `y` into 2D grids for adjacency handling
X_grid = reshape(X, [10, 10, 2]); % Original grid
y_grid = reshape(y, [10, 10, 2]); % Transformed grid

perturbation = (-1).^randi([0,1], 100, 2) * 0.2;
y_noisy = y + perturbation;
y_grid_noisy = reshape(y_noisy, [10, 10, 2]); % Transformed grid

% Create figure with subplots
figure('Position', [1, 1, 600, 200])
tiledlayout(1,3, 'Padding', 'compact', 'TileSpacing', 'compact');

% --- Left subplot: Original Grid ---
nexttile;
hold on;
scatter(X(:,1), X(:,2), 'k', 'filled'); % Plot original grid
title('Original Grid');
xlabel('x_1'); ylabel('x_2');

% Connect adjacent points
for i = 1:10
    for j = 1:10
        p = squeeze(X_grid(i,j,:));

        % Right neighbor
        if j < 10
            pr = squeeze(X_grid(i,j+1,:));
            plot([p(1), pr(1)], [p(2), pr(2)], 'k');
        end

        % Down neighbor
        if i < 10
            pd = squeeze(X_grid(i+1,j,:));
            plot([p(1), pd(1)], [p(2), pd(2)], 'k');
        end
    end
end
hold off;
axis equal;
grid on;

% --- Middle subplot: Transformed Grid ---
nexttile;
hold on;
scatter(y(:,1), y(:,2), 'filled', 'k'); % Plot transformed grid
title('Transformed Grid');
xlabel('y_1'); ylabel('y_2');

% Connect adjacent points
for i = 1:10
    for j = 1:10
        p = squeeze(y_grid(i,j,:));

        % Right neighbor
        if j < 10
            pr = squeeze(y_grid(i,j+1,:));
            plot([p(1), pr(1)], [p(2), pr(2)], 'k');
        end

        % Down neighbor
        if i < 10
            pd = squeeze(y_grid(i+1,j,:));
            plot([p(1), pd(1)], [p(2), pd(2)], 'k');
        end
    end
end
hold off;
axis equal;
grid on;

% --- Right subplot: Noisy Grid ---
nexttile;
hold on;
scatter(y_noisy(:,1), y_noisy(:,2), 'filled', 'k'); % Plot transformed grid
title('Noisy Transformed Grid');
xlabel('y_1'); ylabel('y_2');

% Connect adjacent points
for i = 1:10
    for j = 1:10
        p = squeeze(y_grid_noisy(i,j,:));

        % Right neighbor
        if j < 10
            pr = squeeze(y_grid_noisy(i,j+1,:));
            plot([p(1), pr(1)], [p(2), pr(2)], 'k');
        end

        % Down neighbor
        if i < 10
            pd = squeeze(y_grid_noisy(i+1,j,:));
            plot([p(1), pd(1)], [p(2), pd(2)], 'k');
        end
    end
end
hold off;
axis equal;
grid on;
