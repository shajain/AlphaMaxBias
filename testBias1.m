addpath('./distributions/','./Algorithms/','./Transformations/','./shared/','./SVM/','./densityEstimation/','./plots/','./posterior/','./clustering/');

S=load('~/Data/Bias/finalData.mat');
alpha=S.alpha;

[post,post1,out]=transform_nn_imb(S.X0_N,S.X0_P);
post=changePrior(post,out.pp,alpha);
post1=changePrior(post1,out.pp,alpha);

[alpha_1,gamma_1, post_1,post1_1,out_1]=runPreClustBias(S);
[alpha_2,gamma_2, post_2, post1_2, out_2]=runBias(S);
[alpha_3, post_3, post1_3, out_3]=runUnBias(S);


