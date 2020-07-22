%-------------------------------------------------------------------------%
%  Ant Colony Optimization (ACO) source codes demo version                %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%

function [sFeat,Nf,Sf,curve]=jACO(feat,label,N,T,tau,eta,alpha,beta,rho,phi,Nf)
%---Input------------------------------------------------------------------
% feat:  feature vector (instances x features)
% label: labelling
% N:     Number of ants
% T:     Maximum number of iterations
% alpha: Coefficient control tau
% beta : Coefficient control eta
% tau:   Initial tau
% rho:   Pheromone
% eta:   Initial beta
% phi:   Coefficient 
% Nf:    Set number of selected features
% *Note: k-value of KNN & k-fold setting can be modified in jFitnessFunction.m
%---Output-----------------------------------------------------------------
% sFeat: Selected features (instances x features)
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------


fun=@jFitnessFunction; 
D=size(feat,2); 
tau=tau*ones(D,D); eta=eta*ones(D,D);
curve=inf; fitG=inf; fit=zeros(1,N); tau0=tau; t=1; 
figure(1); clf; axis([1 100 0 0.3]); xlabel('Number of Iterations');
ylabel('Fitness Value'); title('Convergence Curve'); grid on;
%---Iterations start-------------------------------------------------------
while t <= T
	X=zeros(N,Nf); 
	for i=1:N
    X(i,1)=randi([1,D]); k=[];
    for d=2:Nf
      k=[k(1:end),X(i,d-1)];
      P=tau(k(end),:).^alpha.*eta(k(end),:).^beta; 
      P(k)=0;  
      Prob=P./sum(P(:)); 
      SP=jRouletteWheelSelection(Prob);
      X(i,d)=SP;
    end
  end
  for i=1:N
    fit(i)=fun(feat,label,X(i,:));
    if fit(i) < fitG
      Xgb=X(i,:); fitG=fit(i); 
    end
  end
  tour=Xgb; tour(tour==0)=[]; tour=[tour(1:end),tour(1)];
  for d=1:length(tour)-1
    x=tour(d); y=tour(d+1);
    Dtau=1/fitG;
    tau(x,y)=(1-phi)*tau(x,y)+phi*Dtau; 
  end
  tau=(1-rho)*tau+rho*tau0; curve(t)=fitG;
  pause(1e-20); hold on;
  CG=plot(t,fitG,'Color','r','Marker','.'); set(CG,'MarkerSize',5);
  t=t+1;
end
Sf=unique(Xgb); sFeat=feat(:,Sf); 
end


function Route=jRouletteWheelSelection(Prob)
C=cumsum(Prob); P=rand();
for i=1:length(C)
	if C(i) > P
    Route=i; break;
  end
end
end      

