function pnPost = PNpostCal_imb(pnPost,oldPrior,newPrior)
%Adjusts the PN posterior obtained after balancing the positive and negative
%classes to the posterior reflecting the true prior
pnPost=pnPostCal(pnPost);
pnRatio=PNpost2PNratio(pnPost,oldPrior);
pnPost=PNRatio2PNPost(pnRatio,newPrior);
end

