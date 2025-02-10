function timing

    forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
    
    allPoints = load(['..' filesep 'output' filesep 'regionProperties.mat']);
    allPoints = allPoints.regionProperties;


    muaArray = muaCalculation(allPoints);
    mus = allPoints(:,end);

    %num_wavelengths = width(muaArray);
    num_wavelengths = 50;
%%
    timings = zeros([1,20]);

    for i = 1:length(timings)
        tic
        for j = 1:num_wavelengths
            tempMesh = forearmMesh;
            tempMesh = setMeshProperties(tempMesh,muaArray(i,j),mus(i));
            temp = femdata_FD(tempMesh, 0);
        end
        timings(i) = toc;
    end

    mean_timings = mean(timings)
    std_timings = std(timings)

    total_iterations = 78125;
    total_wv = 211;

    total_time = mean_timings * (total_wv / num_wavelengths) * total_iterations
    total_std = std_timings * (total_wv / num_wavelengths) * sqrt(total_iterations)

    total_time_hours = total_time / 60 / 60

end

