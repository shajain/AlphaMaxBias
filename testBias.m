S=load('~/Data/Bias/finalData.mat');
X=S.X;
X1=S.X1;
C1=S.cluster_X1;
C=S.cluster_X;
opts=struct();
opts.M=5;
[alpha, gamma, out]=alphamaxB(X,X1,opts);
opts.C1=C1;
opts.C=C;
[alpha2, gamma2, out2]=alphamaxB(X,X1,opts);

[alpha3,out3]=estimateMixprop(X,X1,'AlphaMax');
