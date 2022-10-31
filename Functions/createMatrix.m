function [X,Y] = createMatrix(conf1,conf2,Data)
%% Create a training and a test matrix

X = [];
Y = [];

for sbj = [1:13 16:25]
    X = [X; Data(sbj).Participant(1).Task(conf1).EEGConfig];
    Y = [Y; ones(size(Data(sbj).Participant(1).Task(conf1).EEGConfig,1),1)];    
end

for sbj = [1:13 16:25]
    X = [X; Data(sbj).Participant(1).Task(conf2).EEGConfig];
    Y = [Y; ones(size(Data(sbj).Participant(1).Task(conf2).EEGConfig,1),1)*2];    
end


end