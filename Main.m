%-------------------------------------------------------------------------%
%  Ant Colony Optimization (ACO) source codes demo version                %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%


%---Input------------------------------------------------------------------
% feat:  feature vector (instances x features)
% label: labelling
% N:     Number of ants
% T:     Maximum number of iterations
% alpha: Coefficient control tau
% beta : Coefficient control eta
% tau:   Initial tau
% eta:   Initial beta
% rho:   Pheromone
% phi:   Coefficient 
% Nf:    Set number of selected features
% *Note: k-value of KNN & hold-out setting can be modified in jFitnessFunction.m
%---Output-----------------------------------------------------------------
% sFeat: Selected features (instances x features)
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------

%% Ant Colony Optimization
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 
% Parameter setting
N=10; T=100; tau=1; eta=1; alpha=1; beta=1; rho=0.2; phi=0.5; 
% Set number of selected features
Nf=15; 
% Ant Colony Optimization
[sFeat,Nf,Sf,curve]=jACO(feat,label,N,T,tau,eta,alpha,beta,rho,phi,Nf);
% Plot convergence curve
figure(); plot(1:T,curve); xlabel('Number of Iterations');
ylabel('Fitness Value'); title('ACO'); grid on;






