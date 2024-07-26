clear all
close all
clc

restoredefaultpath;
cd(fileparts(mfilename('fullpath')));
%addpath(genpath('NIRFASTer-master'));

addpath(genpath(['..' filesep '..' filesep '..' filesep 'NIRFASTER-master']))
addpath(genpath(['..']))



%%%

forearmMesh = createForearmMesh;

plotmesh(forearmMesh)
plotmesh_fiducials(forearmMesh)

[allPointProperties,crustProperties] = findRegionProperties();
syntheticData = runForearmSimulations(forearmMesh,allPointProperties,'');

%%%

forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
allPoints = load(['..' filesep 'output' filesep 'regionProperties.mat']);
allPoints = allPoints.regionProperties;

syntheticData = load(['..' filesep 'output' filesep 'syntheticData_.mat']);
syntheticData = syntheticData.syntheticData;


%save(['..' filesep 'output' filesep 'syntheticData'], 'syntheticData');

