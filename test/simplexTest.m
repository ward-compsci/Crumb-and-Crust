function simplexTest(obsSet,point)


    %rng(1);
    obsSet = rand([50,2]);
    point = rand([1,2]);
    point = [0,1];

    [simplex,distances,point] = findSimplex(obsSet,point);

    %simplex = [simplex;simplex(1,:)];


    figure
    hold on;
    scatter(obsSet(:,1),obsSet(:,2));
    scatter(point(:,1),point(:,2));

    plot(simplex(:,1),simplex(:,2));

    obsSet = rand([50,3]);
    point = rand([1,3]);
    %point = [.5,.5,.5];

    [simplex,distances,point] = findSimplex(obsSet,point);
    %simplex = [simplex; simplex(1,:)];
    
    figure
    scatter3(obsSet(:,1), obsSet(:,2), obsSet(:,3), 'filled');
    hold on;
    scatter3(point(1), point(2), point(3), 'r', 'filled');
    %patch('Vertices', simplex, 'Faces', [1 2 3], 'FaceAlpha',.3);
    
    % Define the faces of the tetrahedron using indices of the points
    faces = [1,2,3; 1,2,4;1,3,4;2,3,4];
    
    % Plot the tetrahedron
    patch('Vertices', simplex, 'Faces', faces, 'FaceColor', 'black', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

end