function [X,Y] = createMatrix(conf1,conf2,Data)
%% Takes configuration 1, 2 and the EEG Data as an input and output X and Y dataset
X = [];
Y = [];

counter = 1;
for k = 1:length(Data)
    
    if isstruct(Data(k).Participant)
        idx(counter) = k;
    counter = counter+1;
    end
end
for sbj = idx
    X = [X; Data(sbj).Participant(2).Task(conf1).EEGConfig];
    Y = [Y; ones(size(Data(sbj).Participant(2).Task(conf1).EEGConfig,1),1)];
    
end

for sbj = idx
    X = [X; Data(sbj).Participant(2).Task(conf2).EEGConfig];
    Y = [Y; ones(size(Data(sbj).Participant(2).Task(conf2).EEGConfig,1),1)*2];
    
end




end