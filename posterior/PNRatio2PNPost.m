function pnPost = PNRatio2PNPost(pnRatio,prior)
%Converts ratio of postive to negative density to PN posterior
pnPost = pnRatio./(pnRatio+(1-prior)/prior);
pnPost=PNpostCal(pnPost);
end

