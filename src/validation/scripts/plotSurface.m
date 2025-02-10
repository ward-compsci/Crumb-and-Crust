function plotSurface()
    

    target_length = 4096; % perfect square, perfect cube

    yLims = [0.001 + 0.01, .99];
    % yLims = [10, 50];

    points = 5;

    y = linspace(yLims(1), yLims(2), round(sqrt(target_length)));
    y_true = cartesian(y,y);
       
    % base = 1.5 + (2.5-1.5) * rand;
    base = exp(1);
    x_true = generateXValues_2(y_true);

    x = y_true(:,1);
    y = y_true(:,2);

    xlin = linspace(min(x), max(x), 100);
    ylin = linspace(min(y), max(y), 100);

    % Create meshgrid for X and Y
    [X,Y] = meshgrid(xlin, ylin);
    
    % Z values for the surface plot (from the x dataset)
    Z = griddata(x,y,x_true,X,Y,'v4');

    
    % Define the view angle (azimuth, elevation)
    azimuth = 120;  % Horizontal rotation (degrees)
    elevation = 50; % Vertical rotation (degrees)

    %%
    figure
    tiledlayout(2,2,'TileSpacing','Compact');
    nexttile
    surf(X, Y, Z,'FaceAlpha',0.5);
    
    xlabel('\boldmath{$\theta_1$}', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('\boldmath{$\theta_2$}', 'Interpreter', 'latex', 'FontSize', 20);
    zlabel('\boldmath{$\pi$}', 'Interpreter', 'latex', 'FontSize', 20);

    title('Gridlike', 'Fontsize', 20);


    yLattice = generateBruteForcePoints_validation(points,yLims,2);
    Z_points = griddata(x, y, x_true, yLattice(:,1), yLattice(:,2), 'v4');  % Interpolate to get the Z values at x, y

    hold on;
    scatter3(yLattice(:,1), yLattice(:,2), Z_points, 50, 'r', 'filled');  % Scatter plot of the points
    hold off;

    view(azimuth, elevation);


    %%
    nexttile
    surf(X, Y, Z,'FaceAlpha',0.5);

    xlabel('\boldmath{$\theta_1$}', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('\boldmath{$\theta_2$}', 'Interpreter', 'latex', 'FontSize', 20);
    zlabel('\boldmath{$\pi$}', 'Interpreter', 'latex', 'FontSize', 20);
    title('Gradient', 'Fontsize', 20);

    yLattice = generateGradientPoints_validation_2(points,yLims,2,1);
    Z_points = griddata(x, y, x_true, yLattice(:,1), yLattice(:,2), 'v4');  % Interpolate to get the Z values at x, y

    hold on;
    scatter3(yLattice(:,1), yLattice(:,2), Z_points, 50, 'r', 'filled');  % Scatter plot of the points
    hold off;

    view(azimuth, elevation);

    %%
    nexttile
    surf(X, Y, Z,'FaceAlpha',0.5);
    
    xlabel('\boldmath{$\theta_1$}', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('\boldmath{$\theta_2$}', 'Interpreter', 'latex', 'FontSize', 20);
    zlabel('\boldmath{$\pi$}', 'Interpreter', 'latex', 'FontSize', 20);

    title('Crust & Crumb', 'Fontsize', 20);

    yLattice = generateCrustCrumbPoints_validation_2(points,yLims,2,1);
    Z_points = griddata(x, y, x_true, yLattice(:,1), yLattice(:,2), 'v4');  % Interpolate to get the Z values at x, y

    hold on;
    scatter3(yLattice(:,1), yLattice(:,2), Z_points, 50, 'r', 'filled');  % Scatter plot of the points
    hold off;

    view(azimuth, elevation);

    %%
    nexttile
    surf(X, Y, Z,'FaceAlpha',0.5);
    
    xlabel('\boldmath{$\theta_1$}', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('\boldmath{$\theta_2$}', 'Interpreter', 'latex', 'FontSize', 20);
    zlabel('\boldmath{$\pi$}', 'Interpreter', 'latex', 'FontSize', 20);

    title('Random', 'Fontsize', 20);

    yLattice = generateRandomPoints_validation(points,yLims,2);
    Z_points = griddata(x, y, x_true, yLattice(:,1), yLattice(:,2), 'v4');  % Interpolate to get the Z values at x, y

    hold on;
    scatter3(yLattice(:,1), yLattice(:,2), Z_points, 50, 'r', 'filled');  % Scatter plot of the points
    hold off;

    view(azimuth, elevation);

end