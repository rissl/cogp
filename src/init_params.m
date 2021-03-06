function params = init_params(params,x,y,M,nhyper,z0)
%INIT_PARAMS params = init_params(x,y,M)
%   Init parameters of a single augmented sparse gp.
%
y(isnan(y)) = mean(y(~isnan(y))); %mean(y(~isnan(y))) or 0? for missing data
[N D] = size(x);
idx_z = randperm(N,M);
if isempty(z0)
  z0 = x(idx_z,:);
end  
idx = randperm(N,M);
m =  y(idx);
Sinv = 0.1*(1/var(y))*eye(M);
S = inv(Sinv);
params.m = m;
params.S = S;
params.z = z0;
params.z0 = z0;
if ~isfield(params,'loghyp') || isempty(params.loghyp)
  loghyp = log(ones(nhyper,1));
  params.loghyp = loghyp;
end
params.delta_hyp = zeros(size(params.loghyp));
params.delta_z = zeros(size(z0));
end

