function repeatabilityTest
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);

    temp1 = chromophoreConcentrations();
    temp2 = muaCalculation(temp1);

    data = zeros([1,121]);

    for i = 1:length(temp2)
        forearmMesh = setMeshProperties(forearmMesh,temp2(2,i),temp1(2,end));
        temp = femdata_FD(forearmMesh,0);
        data(i) = temp.amplitude;
    end

    data2 = zeros([1,121]);

    for i = 1:length(temp2)
        forearmMesh = setMeshProperties(forearmMesh,temp2(2,i),temp1(2,end));
        temp = femdata_FD(forearmMesh,0);
        data2(i) = temp.amplitude;
    end

    
    diff = data - data2;
    same = diff < eps;

    if min(same) > 1
        disp('Different results from same parameter set')
    end

end

