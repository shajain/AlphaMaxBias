function idx = find_nearest_vector(x,arr)
    minD = sqrt(sum((x - arr(1,:)) .^ 2));
    idx = 1;
    arr_sz = size(arr);
    n = arr_sz(1);
    for i = 1:n
        D  = sqrt(sum((x - arr(i,:)) .^ 2));
        if D < minD
            idx = i;
        end
    end        
end