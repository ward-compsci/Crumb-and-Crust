function err = errorMethods(xtrue,xinterp,method)
%ERRORMETHODS Summary of this function goes here
%   Detailed explanation goes here

    arguments
        xtrue
        xinterp
        method = 'abs'
    end

    xTrue = xtrue;
    xInterp = xinterp;

    if strcmp(method,'abs')
        err = (abs(xTrue - xInterp));
    elseif strcmp(method,'rel')
        err = (abs((xTrue - xInterp)./xTrue));
    else
        disp('Undefined method')
    end

end

