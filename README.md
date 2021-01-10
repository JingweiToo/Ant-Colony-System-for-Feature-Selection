# Ant Colony System for Feature Selection

[![View Ant Colony System for Feature Selection on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/71989-ant-colony-system-for-feature-selection)
[![License](https://img.shields.io/badge/license-BSD_3-yellow.svg)](https://github.com/JingweiToo/Ant-Colony-System-for-Feature-Selection/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/badge/release-1.1-green.svg)](https://github.com/JingweiToo/Ant-Colony-System-for-Feature-Selection)

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/ee0b62f0-75c7-41fd-b5b5-0ed190a65eaf/3a3c48b1-760c-425a-a130-902ada3669f6/images/screenshot.PNG)

## Introduction
* This toolbox offers ant colony system ( ACS )  
* The `Main` file illustrates the example of how ACS can solve the feature selection problem using benchmark data-set


## Input
* *`feat`*     : feature vector ( Instances *x* Features )
* *`label`*    : label vector ( Instances *x* 1 )
* *`N`*        : number of ants
* *`max_Iter`* : maximum number of iterations
* *`alpha`*    : coefficient control tau
* *`beta`*     : coefficient control eta
* *`tau`*      : initial tau
* *`eta`*      : initial eta
* *`rho`*      : pheromone
* *`phi`*      : coefficient 
* *`Nf`*       : set number of selected features


## Output
* *`sFeat`*    : selected features
* *`Sf`*       : selected feature index
* *`Nf`*       : number of selected features
* *`curve`*    : convergence curve


### Example
```code
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

% Parameter setting
N        = 10; 
max_Iter = 100; 
tau      = 1; 
eta      = 1; 
alpha    = 1; 
beta     = 1; 
rho      = 0.2; 
phi      = 0.5; 
Nf       = 15;       % Set number of selected features
% Ant Colony System
[sFeat,Nf,Sf,curve] = jACO(feat,label,N,max_Iter,tau,eta,alpha,beta,rho,phi,Nf,HO);

% Plot convergence curve
plot(1:max_Iter,curve); 
xlabel('Number of Iterations');
ylabel('Fitness Value');
title('ACS'); grid on;
```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox

