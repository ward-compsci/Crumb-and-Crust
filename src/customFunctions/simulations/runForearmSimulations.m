function syntheticData = runForearmSimulations(mesh,regionProperties)
%RUNFOREARMSIMULATIONS Summary of this function goes here
%   Detailed explanation goes here

    muaArray = muaCalculation(regionProperties);
    mus = regionProperties(:,end);

    [numPoints,numWavelengths] = size(muaArray);
    syntheticData = zeros([numPoints,numWavelengths]);
    

    tempDir = ['..' filesep 'output' filesep 'tempSyntheticDataFiles'];
    if ~exist("tempDir", 'dir')
        mkdir(tempDir);
    end
    addpath(genpath(tempDir));

    pool = gcp('nocreate');
    if isempty(pool)
        pool = parpool;
        poolCreated = true;
    else
        poolCreated = false;
    end

    parfor j = 1:numWavelengths
        tempSyntheticData = zeros([numPoints,1]);

        for i = 1:numPoints
            tempMesh = mesh;
            tempMesh = setMeshProperties(tempMesh,muaArray(i,j),mus(i));
            temp = femdata_FD(tempMesh, 0);
            tempSyntheticData(i) = temp.amplitude;
            syntheticData(i,j) = tempSyntheticData(i);
        end

        saveFileName = sprintf('tempSyntheticData_%d', j);
        tempStruct = struct('tempSyntheticData', tempSyntheticData);
        save([tempDir filesep saveFileName], '-fromstruct', tempStruct);
        
    end

    if poolCreated
        delete(pool);
    end

    save(['..' filesep 'output' filesep 'syntheticData'], 'syntheticData');

    if exist(tempDir, 'dir')
        rmdir(tempDir, 's');
    end

end
