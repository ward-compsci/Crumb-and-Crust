restoredefaultpath;
cd(fileparts(mfilename('fullpath')));
addpath(genpath(".."));

clear all
close all
clc



%% 
rng(21);
cycles = 50;
samplingPoints = 3:1:6;
pert = .1;
yLims = [1, 100];
method = 'rel';
test_points = 500;

for points = samplingPoints
   multi2D_all.(['points' int2str(points)]) = comparison(yLims,points,2,pert,method,cycles,test_points);
   multi3D_all.(['points' int2str(points)]) = comparison(yLims,points,3,pert,method,cycles,test_points);
end

samplingTable = statisticalTests(multi2D_all,multi3D_all);

rbf_results = plotVaryingPoints(samplingTable);

plotErrorSTD(rbf_results)


for points = samplingPoints
    multi2D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,2,pert,method,cycles,test_points);
    multi3D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,3,pert,method,cycles,test_points);
    multi4D_rbf.(['points' int2str(points)]) = comparison_rbf(yLims,points,4,pert,method,cycles,test_points);
end

samplingTable_rbf = statisticalTests_rbf(multi2D_rbf,multi3D_rbf,multi4D_rbf);


