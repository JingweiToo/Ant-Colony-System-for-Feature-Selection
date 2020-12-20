function [sFeat,Nf,Sf,curve] = jACO(feat,label,N,max_Iter,tau,eta,...
  alpha,beta,rho,phi,Nf,HO)

fun  = @jFitnessFunction; 
dim  = size(feat,2); 
tau  = tau * ones(dim,dim); 
eta  = eta * ones(dim,dim);
tau0 = tau; 

fitG = inf; 
fit  = zeros(1,N); 

curve = inf;
t = 1; 
%---Iterations start---------------------------------------------------
while t <= max_Iter
	X = zeros(N,Nf); 
	for i = 1:N
    X(i,1) = randi([1,dim]); 
    k      = [];
    for d = 2:Nf
      k      = [k(1:end), X(i, d-1)];
      P      = tau(k(end),:) .^ alpha .* eta(k(end),:) .^ beta; 
      P(k)   = 0;  
      prob   = P ./ sum(P(:)); 
      route  = jRouletteWheelSelection(prob);
      X(i,d) = route;
    end
  end
  for i = 1:N
    fit(i) = fun(feat,label,X(i,:),HO);
    if fit(i) < fitG
      Xgb  = X(i,:); 
      fitG = fit(i); 
    end
  end
  tour = Xgb;  tour(tour == 0) = [];
  tour = [tour(1:end), tour(1)];
  for d = 1 : length(tour) - 1
    x        = tour(d); 
    y        = tour(d + 1);
    Dtau     = 1 / fitG;
    tau(x,y) = (1 - phi) * tau(x,y) + phi * Dtau; 
  end
  tau = (1 - rho) * tau + rho * tau0; 
  curve(t) = fitG;
  fprintf('\nIteration %d Best (ACS)= %f',t,curve(t))
  t = t + 1;
end
Sf    = unique(Xgb);
sFeat = feat(:,Sf); 
end


function Route = jRouletteWheelSelection(prob)
C = cumsum(prob); 
P = rand();
for i = 1:length(C)
	if C(i) > P
    Route = i;
    break;
  end
end
end      

