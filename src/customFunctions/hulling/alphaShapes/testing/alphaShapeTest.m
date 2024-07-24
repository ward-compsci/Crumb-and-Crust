%Test script to visualise alpha shape generation in 2D and 3D

rng(1)

%% 2D

points2D = rand([50,2]);
alpha2D = .5;

alphaShape2D = findAlphaShape(points2D,alpha2D);

plotAlphaShape(alphaShape2D,points2D)


%% 3D

points3D = rand([100,3]);
alpha3D = .3;

alphaShape3D = findAlphaShape(points3D,alpha3D);

plotAlphaShape(alphaShape3D,points3D)

