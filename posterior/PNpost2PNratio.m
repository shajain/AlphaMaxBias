function pnRatio = PNpost2PNratio(pnPost,prior)
%Converts PN posterior to the ration of positive and negative densities.
%Infinite values are handeled appropriately
EPS =10^-8;
pnPost = PNpostCal(pnPost);
pnRatio = pnPost./(1-pnPost);
pnRatio(isinf(pnRatio))=max(pnRatio(isfinite(pnRatio)))+EPS;
pnRatio = (1-prior)/prior *pnRatio;
end

