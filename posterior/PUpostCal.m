function puPost = PUpostCal(puPost,c,prior)
%Calibrates a PU posterior so that the largest value it can achieve is
%1/(1+c*prior)
%puPost= PNpostCal(puPost);
%puPost= puPost/(1+c*prior);
EPS=10^-8;
maxPUPost=1/(1+c*prior);
puPost(puPost>maxPUPost)=maxPUPost-EPS;
%mx=max(puPost);mn=min(puPost);
%puPost=(puPost-mn)/(mx-mn);
%puPost=puPost*maxPUPost;
end
