function interpolatedValues = interpolationMethods(yvalues,xvalues,yfullset,method)
%INTERPOLATIONMETHODS Summary of this function goes here
%   Detailed explanation goes here

    arguments
       yvalues
       xvalues
       yfullset
       method = 'linear'
    end

    yValues = yvalues;
    xValues = xvalues;
    yFullSet = yfullset;


    if strcmp(method,'linear')
        if width(yFullSet) > 1
            F = scatteredInterpolant(yValues,xValues);
            interpolatedValues = F(yFullSet);
        else
            interpolatedValues = interp1(yValues,xValues,yFullSet);
        end
        
    elseif strcmp(method,'RBF')
        F = rbfcreate(yValues',xValues');
        interpolatedValues = rbfinterp(yFullSet',F);
        interpolatedValues = interpolatedValues.';

    elseif strcmp(method,'natural')
        if width(yFullSet) > 1
            F = scatteredInterpolant(yValues,xValues,'natural');
            interpolatedValues = F(yFullSet);
        else
            interpolatedValues = interp1(yValues,xValues,yFullSet,'natural');
        end
    else
        disp('Undefined method')
    end


end

