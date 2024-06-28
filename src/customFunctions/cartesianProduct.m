function C = cartesianProduct(boundaryPoints)

    n = size(boundaryPoints,2);
    
    [F{1:n}] = ndgrid(boundaryPoints{:});
    

    for i=n:-1:1
        G(:,i) = F{i}(:);
    end

    %C = unique(G , 'rows');
    C = G;
  
end