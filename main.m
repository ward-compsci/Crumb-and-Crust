clear all
close all
clc

restoredefaultpath;
cd(fileparts(mfilename('fullpath')));
%addpath(genpath('NIRFASTer-master'));

%addpath(genpath(['..' filesep '..' filesep 'NIRFASTER-master']))
addpath(genpath(['.']))




%forearmMesh = createForearmMesh;


%chromophoreConcentrations();


%forearmMesh = load_mesh(['Mesh' filesep 'forearmMesh'])

%plotmesh(forearmMesh)
%plotmesh_fiducials(forearmMesh)

[allPointProperties,crustProperties] = findRegionProperties();