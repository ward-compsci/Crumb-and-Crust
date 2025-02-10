
yLims = [0.1,10];
nPoints = 5;
dimensions = 2;

target_length = 729;

y = linspace(yLims(1), yLims(2), round(sqrt(target_length)));
y_true = cartesian(y,y);

x_true = -log(y_true(:,1) + y_true(:,2))
[x_sorted, sort_idx] = sort(x_true, 'descend');

figure
plot(x_true)

%%
num_samples = length(y_true);
distribution = -log(linspace(yLims(1),yLims(2),num_samples));
distribution_sorted = distribution(sort_idx); % Reorder to match x_true

figure
plot(distribution_sorted)
