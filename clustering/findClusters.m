function [cluster_X0 , cluster_X1, num_clusters,out] = findClusters(X0,X1,M)
    
    n_s_X0 = size(X0,1);
    n_s_X1 = size(X1,1);
    
   %Project to the high dimensional datasets to a 50 dimensional space
    d = size(X1,2);
    n_f = size(X1,2);
    X1_P = X1;
    X0_P = X0;
    if n_f > 50
        d = 50;
        P = (1/sqrt(d))*randn(d,n_f);
        X0_P = (P*(X0'))';
        X1_P = (P*(X1'))';
    end
    
    
    sc = -1;
    cluster_X1 = zeros(size(X1_P,1),1);
    centroid_X1 = [];
    sc_M = zeros(M,1);
   %Cluster positives 
    num_clusters = 2;
    for n_c = 2:M
        [idx,ctrd] = kmeans(X1_P,n_c,'Replicates',10);
        sc_M(n_c,1) = silhouette_coefficient (X1_P, idx, n_c);
        if sc_M(n_c,1) > sc
            num_clusters = n_c;
            sc = sc_M(n_c,1);
            cluster_X1 = idx;
            centroid_X1 = ctrd;
        end
    end
    
    %assign clusters to unlabeled points by finding the closest point in
    %the positive clustering.
    cluster_X0 = zeros(size(X0_P,1),1);
    for i = 1:size(X0_P,1)
        cluster_X0(i) = find_nearest_vector(X0_P(i,:),centroid_X1);
    end
    
    %Assign cluster sizes
    cSize=[];
    cSize1=[];
    for ix=1:num_clusters
        cSize=[cSize,sum(cluster_X0==ix)];
        cSize1=[cSize1,sum(cluster_X1==ix)];
    end
    out.sc=sc_M;
    out.cSize=cSize;
    out.cSize1=cSize1;
    out.nClust=num_clusters;
end



% function [cluster_X , cluster_X1] = findClusters(X,X1,M)
% sse = 0;
% cluster_X1 = zeros(size(X1,1),1);
% centroid_X1 = [];
% for n_c = 2:M
%     [idx,ctrd] = kmeans(X1,n_c);
%     sse_current = silhouette_coefficient (X1, idx, n_c);
%     if sse_current > sse
%         cluster_X1 = idx;
%         centroid_X1 = ctrd;
%         sse=sse_current;
%     end
% end
% cluster_X = zeros(size(X,1),1);
% for i = 1:size(X,1)
%     cluster_X(i) = find_nearest_vector(X(i,:),centroid_X1);
% end
% 
% end
% 
