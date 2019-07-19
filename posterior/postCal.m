function post = PNpostCal(post)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
post= post-min(post);
post=post/max(post);
end

