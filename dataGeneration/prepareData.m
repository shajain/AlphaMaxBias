fileName = './RealDatasets/bank/clusterData.mat';
temp = strfind(fileName,'/');
temp = temp(end);
folderName = fileName(1:temp);
clusterData_fileName = strcat(folderName, 'finalData' );

[XX1, XX0, cluster_XX1, cluster_XX0, n_c] = loadData(fileName);

[X0_N, cluster_X0_N, X0_P, cluster_X0_P , X1, cluster_X1, alpha, zetas, gammas] = makeData(XX1, XX0, cluster_XX1, cluster_XX0, n_c);
X = [X0_P;X0_N];
cluster_X = [cluster_X0_P;cluster_X0_N];

save(clusterData_fileName, 'X0_N', 'cluster_X0_N', 'X0_P', 'cluster_X0_P' , 'X1', 'cluster_X1', 'X', 'cluster_X',  'alpha', 'zetas', 'gammas')



function [Y0_N, cluster_Y0_N, Y0_P, cluster_Y0_P , Y1, cluster_Y1, alpha, zetas, gammas] = makeData(X1, X0, cluster_X1, cluster_X0, n_c)

    [Y0_P, Y1, cluster_Y0_P, cluster_Y1, zetas] = getBiasedPositiveAndMixedPositiveData(X0, X1, cluster_X0, cluster_X1, n_c);
    
    
    %pool for mixture
    negative_pool_size = size(X0,1);
    positive_pool_size = size(Y0_P,1);
    alpha = 0.1 + 0.8*rand(1);
    
    unlabelled_sample_size = min(floor(positive_pool_size/alpha) , floor(negative_pool_size/(1-alpha)));
    
    %if positive pool size is less, then number of negatives to be lessened,
    %if negative pool size is less, then we need to redo the positive data.
    %if unlabelled_sample_size < 10000
    if positive_pool_size/alpha <= negative_pool_size/(1-alpha)
       negative_sample_size = unlabelled_sample_size - positive_pool_size;
       neg_idx = randperm(negative_pool_size, negative_sample_size);
       Y0_N = X0(neg_idx,:);
       cluster_Y0_N = cluster_X0(neg_idx,:);
    else
        Y0_P_new = [];
        cluster_Y0_P_new = [];
        new_positive_sample_size =  unlabelled_sample_size - negative_pool_size;
        temp = new_positive_sample_size/positive_pool_size;
        for i = 1:n_c
            c_i = Y0_P(cluster_Y0_P == i);
            c_i_sample_size = floor(temp*size(c_i,1));
            c_i_index = randperm(size(c_i,1),c_i_sample_size);
            Y0_P_new = [Y0_P_new; c_i(c_i_index)];
            cluster_Y0_P_new = [cluster_Y0_P_new; zeros(c_i_sample_size,1)+i];
        end
        Y0_P = Y0_P_new;
        cluster_Y0_P = cluster_Y0_P_new;
        Y0_N = X0;
        cluster_Y0_N = cluster_X0;
    end
%    else
%        negative_sample_size = unlabelled_sample_size - positive_pool_size
%    end


    gammas = zeros(n_c,1);
    for i = 1:n_c
        gammas(i,1) = size(Y0_P(cluster_Y0_P==i))/size(Y0_P);
    end
end


function [Y, Y1, cluster_Y, cluster_Y1, zetas] = getBiasedPositiveAndMixedPositiveData(X0, X1, cluster_X0, cluster_X1, n_c)
    lambdas = rand(n_c,1);
    d = size(X1,2);
    Y1 = double.empty(0,d);
    Y = double.empty(0,d);
    cluster_Y1 = double.empty(0,1);
    cluster_Y = double.empty(0,1);
    for i = 1:n_c
        c_i = X1(cluster_X1==i,:);
        clusterSize = size(c_i,1);
        bpool_idx = randperm(clusterSize, floor(lambdas(i)*clusterSize));
        b_c_i = c_i(bpool_idx,:);
        Y1 = [Y1; b_c_i];
        cluster_Y1 = [cluster_Y1;zeros(size(b_c_i,1),1)+i];
        ubpool_idx = ones(clusterSize,1);
        ubpool_idx(bpool_idx,1) = 0;
        ub_c_i = c_i(ubpool_idx==1,:);
        Y = [Y; ub_c_i];
        cluster_Y = [cluster_Y;zeros(size(ub_c_i,1),1)+i];
        %size(c_i,1)
        %size(b_c_i,1)
        %size(ub_c_i,1)
        %disp(' ')
    end
    
    zetas = zeros(n_c,1);
    for i = 1:n_c
        zetas(i,1) = size(Y1(cluster_Y1==i))/size(Y1);
    end
end



function [X1, X0, cluster_X1, cluster_X0, n_c] = loadData(fileName)
    data = load(fileName);
    X1 = data.X1;
    X0 = data.X0;
    cluster_X1 = data.cluster_X1;
    cluster_X0 = data.cluster_X0;
    n_c = data.n_c;
end