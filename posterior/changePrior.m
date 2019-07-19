function pnPost = changePrior(pnPost,alphaOld,alphaNew)
%Reflect the change is posterior after a change in alpha
pnRatio=PNpost2PNratio(pnPost,alphaOld);
pnPost=PNRatio2PNPost(pnRatio, alphaNew);
end
