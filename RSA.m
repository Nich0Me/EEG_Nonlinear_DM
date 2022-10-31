clear all
close all

addpath('./Functions')

%% Load Subtraction Task
load ./Data/Task1_100Downsampled
%% Load Addition Task
% load Task2_100Downsampled

%% Select couples of configuration

for conf1 = 1:25
    for conf2 = 1:25
        
        if conf2 <= conf1

        else
            % Create X and Y dataset
            [X,Y] = createMatrix(conf1, conf2, DataStructure);
            
            % WaitSecs(5)
            acc(conf1,conf2,:) = run_svm(X,Y);
            disp(['Conf1_' num2str(conf1),' and Conf2_', num2str(conf2),' done'])
        end
    end
end