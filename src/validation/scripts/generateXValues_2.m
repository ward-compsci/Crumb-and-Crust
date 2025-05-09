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
    eps = 1e-10;

    if width(measurements) > 1
        P = -log(sum(measurements, 2) + eps) / log(base + eps);
    else
        P = -log(measurements + eps) / log(base + eps);
    end

end
