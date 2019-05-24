function [sc] =  silhouette_coefficient (X, y, M)

% silhouette coefficient
sc = 0;

N = size(X, 1);
K = size(X, 2);

D = reshape(sqrt(sum((repmat(X, N, 1) - reshape(repmat(X, 1, N)', K, N * N)') .^ 2, 2)), N, N)';

s = zeros(N, M);
for i = 1 : N
    for m = 1 : M
        q = find(y == m);
        s(i, m) = mean(D(i, setdiff(q, i)));
    end
    
    a(i) = s(i, y(i));
    b(i) = min(s(i, setdiff(1:M, y(i))));
    p(i) = (b(i) - a(i)) / max([a(i) b(i)]);
end
    
for m = 1 : M
    avesc(m) = mean(p(y == m));
end

sc = mean(avesc);

return