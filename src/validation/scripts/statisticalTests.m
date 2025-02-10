function samplingTable = statisticalTests(varargin)
    % This function performs a statistical comparison of the interpolation methods
    % across all datasets (e.g., points3, points4) combined together.
    
    
    temp = varargin{1};
    names = fieldnames(temp);
    pointsLen = length(names);
    cycles = temp.(names{1}).cycles;

    sz = [pointsLen*4*3*cycles*length(varargin) 6]; % Sampled points * lattices * cycles * dimensions
    varTypes = ["double","double","string","string","double","double"];
    varNames = ["Dimension","Sampling","Lattice","Interpolation","Cycle","Error"];
    samplingTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
    
    samplingDesigns = categorical({'Grid-like', 'Gradient', 'Random', 'Crust Crumb'});
    interpolations = categorical({'Linear', 'RBF', 'Natural'});

    points = [3, 4, 5, 6];
    

    idx = 1;

    %.err takes the form (point:interpMethod:lattice:cycle)

    for i = 1:length(varargin) % Dataset (2D / 3D) - 2
        for j = 1:pointsLen % Points per axis (3 / 4 / 5 / 6 / 7 / 8) - 6
            for k = 1:3 % Interp method
                for l = 1:4 % sampling designs
                    temp = varargin{i}.(names{j}).err(:,k,l,:);
                    temp = mean(temp,1);
                    temp = squeeze(temp).';
                    for m = 1:cycles
                        samplingTable(idx,:) = {i+1,points(j),samplingDesigns(l),interpolations(k),m,temp(1,m)};
                        idx = idx + 1;
                    end
                end
            end
        end
    end

    
   

    % Fit the mixed-effects model
    % lme = fitlme(samplingTable, 'Error ~ Interpolation + (1|Sampling) + (1|Sampling:Lattice)')
    lme = fitlme(samplingTable, 'Error ~ Interpolation + (1|Dimension) + (1|Dimension:Sampling) + (1|Dimension:Sampling:Lattice)')

    % Filter the data for RBF Interpolation
    rbfData = samplingTable(samplingTable.Interpolation == 'RBF', :);
     
    % Fit the model for RBF interpolation
    % lme_rbf = fitlme(rbfData, 'Error ~ Lattice + (1|Sampling) + (1|Sampling:Interpolation)')
    lme_rbf = fitlme(rbfData, 'Error ~ Lattice + (1|Dimension) + (1|Dimension:Sampling) + (1|Dimension:Sampling:Interpolation)')

    % disp(lme_rbf.Coefficients);

    contrast = [0 -1 0 1]; % (Intercept, Gradient, Random, Crust Crumb)

    [p, F, df1, df2] = coefTest(lme_rbf, contrast);
    fprintf('Contrast Test Results: p = %.5f, F = %.3f, df1 = %d, df2 = %d\n', p, F, df1, df2);



end
