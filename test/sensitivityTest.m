function sensitivityTest


    numParams = 5;

    initialValues = ones([1,5]) * 1e-1;

    increaseFactor = ones([1,5]);

    numSteps = 10;

    testPoints = ones([numSteps*numParams,numParams]) * 1e-1;

    for i = 1:numParams
        increase = linspace(initialValues(i), increaseFactor(i), numSteps);
        testPoints(((i*numSteps):(numSteps*i)+numSteps-1)-(numSteps-1), i) = increase;
    end



    filePath = ['..' filesep 'output' filesep 'syntheticData_sensitivityTest.mat'];

    % Check if the file exists
    if ~exist(filePath, 'file')
        forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
        testSyntheticData = runForearmSimulations(forearmMesh,testPoints,'sensitivityTest');
    else
        testSyntheticData = load(['..' filesep 'output' filesep 'syntheticData_sensitivityTest.mat']);
        testSyntheticData = testSyntheticData.syntheticData;
    end



    figure
    numPlots = ceil(size(testSyntheticData, 1) / 10);
    xLimits = [1, size(testSyntheticData, 2)];

    for i = 1:numPlots
        start_idx = (i-1) * numSteps + 1;
        end_idx = min(i * numSteps, size(testSyntheticData, 1));
        
        subplot(numPlots, 1, i);
        
        % Plot each row as a separate line
        plot(testSyntheticData(start_idx:end_idx, :)');

        xlim(xLimits);
        
        hold on;
    end


    temp1 = chromophoreConcentrations();
    temp2 = muaCalculation(temp1);

    data = zeros([1,121]);

    for i = 1:length(temp2)
        forearmMesh = setMeshProperties(forearmMesh,temp2(2,i),temp1(2,end));
        temp = femdata_FD(forearmMesh,0);
        data(i) = temp.amplitude;
    end



end
