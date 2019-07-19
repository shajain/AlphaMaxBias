function post = PUpost2PNpost(PUpost,c,prior)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
PUpost= PUpost-min(PUpost);
PUpost=PUpost/max(PUpost);
PUpost= PUpost/(1+c*PUprior);
post = c*prior*PUpost./(1-PUpost);
end

