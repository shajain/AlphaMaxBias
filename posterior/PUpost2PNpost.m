function pnPost = PUpost2PNpost(puPost,c,prior)
%Converts a PU posterior to a PN posterior
puPost= PUpostCal(puPost,c,prior);
pnPost = c*prior*puPost./(1-puPost);
end

