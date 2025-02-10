function meanSTD_validation(data)
%MEANSTD Summary of this function goes here
%   Detailed explanation goes here

    points = data.points;
    err = data.err;
    cycles = data.cycles;


    disp([num2str(points) ' points'])
    samplingDesigns = {'Cubic','Gradient','Random','Crust Crumb'};
    
    k = 2;
    for i = 1:4
        if cycles == 1
            errMean = mean(err(:,i));
            errStd = 0;
        else
            temp = squeeze(mean(err(:,k,i,:),1,'omitnan'));
            errMean = mean(temp,'omitnan');
            errStd = std(temp,'omitnan');
        end
        text = ['Mean / std for ' samplingDesigns{i} ': ' num2str(errMean) '+-' num2str(errStd)];
        disp(text)
    end


end

