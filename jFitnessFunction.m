%-------------------------------------------------------------------------%
%  Fitness Function (Error Rate) source codes demo version                %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%  

function fitness=jFitnessFunction(feat,label,X)
fitness=jwrapperKNN(feat(:,X),label);
end


function ER=jwrapperKNN(feat,label)
%---// Parameter setting for k-value of KNN //
k=5; 
%---// Parameter setting for hold-out (20% for testing set) //
ho=0.2;
Model=fitcknn(feat,label,'NumNeighbors',k,'Distance','euclidean'); 
C=crossval(Model,'holdout',ho);
ER=kfoldLoss(C);
end







