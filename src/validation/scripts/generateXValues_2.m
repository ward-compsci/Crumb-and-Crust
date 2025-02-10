function P = generateXValues_2(measurements, base)
    % measurements: matrix where columns represent dimensions
    % base: scalar specifying the base of the logarithm (default is natural log)
    % weights: optional row vector of weights (1xN, where N is the number of dimensions)

    if nargin < 2 || isempty(base)
        base = exp(1); % Default base is natural logarithm (e)
    end

    % Validate inputs
    if base <= 0 || base == 1
        error('Logarithm base must be greater than 0 and not equal to 1.');
    end

    % Compute the parameter using the weighted sum of negative logs with the specified base
    if width(measurements) > 1
        P = -log(sum(measurements, 2)) / log(base);
    else
        P = -log(measurements) / log(base);
    end

end
