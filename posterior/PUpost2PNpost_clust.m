function pnPost = PUpost2PNpost_clust(puPost,clust,astars,clProp,c)
%Converts a PU posterior to a PN posterior
puPost=puPost(:);
pos_prop=astars.*clProp;
prior=sum(pos_prop);
pos_prop=pos_prop/prior;
neg_prop=(1-astars).*clProp;
neg_prop=neg_prop/sum(neg_prop);
pos_neg_ratio=pos_prop./neg_prop;
pnPost=zeros(length(puPost),1);
pnRatio=zeros(length(puPost),1);
for i = 1:max(clust)
    ix=clust==i;
    pnPost(ix)=PUpost2PNpost(puPost(ix),c(i),astars(i));
    pnRatio(ix)=PNpost2PNratio(pnPost(ix),astars(i));
    pnRatio(ix)=pos_neg_ratio(i)*pnRatio(ix);
    pnPost(ix)=PNRatio2PNPost(pnRatio(ix),prior);
end
end

