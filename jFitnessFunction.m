function cost = jFitnessFunction(feat,label,X,HO)
cost = jwrapperKNN(feat(:,X),label,HO);
end


function error = jwrapperKNN(sFeat,label,HO)
%---// Parameter setting //
k = 5; 

trainIdx = HO.training;        testIdx  = HO.test;
xtrain   = sFeat(trainIdx,:);  ytrain   = label(trainIdx);
xvalid   = sFeat(testIdx,:);   yvalid   = label(testIdx);

My_Model = fitcknn(xtrain,ytrain,'NumNeighbors',k);
pred     = predict(My_Model,xvalid); 
Acc      = sum(pred == yvalid) / length(yvalid);
error    = 1 - Acc; 
end







