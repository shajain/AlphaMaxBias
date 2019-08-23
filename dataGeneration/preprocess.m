M_Cluster = 5;
Max_Biased_Pos = 2000;
Maximum_MixtureSample_size = 10000;
fileName = './RealDatasets/spambase/spambase.mat';

temp = strfind(fileName,'/');
temp = temp(end);
folderName = fileName(1:temp);

[X,y] = loadData(fileName);

X1 = getPositiveDataPts(X,y);
X0 = getNegativeDataPts(X,y);
[cluster_X0, cluster_X1, n_c, out] = findClusters(X0,X1, M_Cluster);

clusterData_fileName = strcat(folderName, 'clusterDataProject' );
save(clusterData_fileName,'X','y','X0', 'cluster_X0', 'X1', 'cluster_X1','n_c');



function [X , y] = loadData(fileName)
    data = load(fileName);
    X = data.X;
    y = data.y;
end

function X1 = getPositiveDataPts(X , y)
    X1 = X(y==1,:);
end

function X0 = getNegativeDataPts(X , y)
    X0 = X(y==0,:);
end

