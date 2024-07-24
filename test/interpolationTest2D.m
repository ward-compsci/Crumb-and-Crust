function interpolationTest2D()
%INTERPOLATIONTEST2D Summary of this function goes here
%   Detailed explanation goes here


    params = {linspace(1,10,10).',linspace(.1,1,10).'};

    [~,parameterSet] = generateCrustCrumbPoints([1,1;10,10],50,3)

    %parameterSet = cartesianProduct(params);

    obsSet = [sum(parameterSet,2), sum(parameterSet.^2, 2)];

    point_param = [8,8];
    point_obs = [sum(point_param), sum(point_param.^2)];

    interpPoint = multivariateInterpolation(parameterSet,obsSet,point_obs)


    figure;
    hold on;
    scatter(parameterSet(:,1),parameterSet(:,2));
    scatter(point_param(1),point_param(2),'g')
    scatter(interpPoint(1),interpPoint(2),'r')


    figure;
    hold on;
    scatter(obsSet(:,1),obsSet(:,2));
    scatter(point_obs(1),point_obs(2),'g')
    scatter(interpPoint(1),interpPoint(2),'r')



    
end

