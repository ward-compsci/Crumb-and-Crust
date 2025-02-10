function mua = melanosomeMua()
%WATERMUA Summary of this function goes here
%   Detailed explanation goes here

% https://omlc.org/spectra/melanin/mua.html

    mua = 1.7e12 * linspace(690,900,211).^(-3.48) * .1;

end

