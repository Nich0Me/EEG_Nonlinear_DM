function [acc] = run_svm(X,Y)

% Randomize all the trials
Shuffle_Sample_idx = randperm(size(X,1),size(X,1));

X = X(Shuffle_Sample_idx,:,:);
Y = Y(Shuffle_Sample_idx);

% Pick number of folds
k_num = 10;

% Mark the fold boundaries
Sample_Boundaries = round(linspace(1,size(X,1),k_num+1));

% Loop over folds
for k = 1:k_num
     
    % Loop over time points
    for t = 1:size(X,3)
        
        fold = Sample_Boundaries(k):Sample_Boundaries(k+1)-1; % Fold position
        trials = 1:size(X,1); % select all trials
        tra = find(~sum(trials == fold')); % Select all trainings
        Xtra = X([tra],:,t); 
        Ytra = Y([tra]);
        % Train SVM Model
        SVMModel = fitcsvm(Xtra,Ytra, 'KernelFunction', 'linear', 'Standardize', true, 'ClassNames', [1,2]);
        
        % Select test set
        Xtest = X(fold,:,t);
        Ytest = Y(fold);
        % Test the model
        [label,score] = predict(SVMModel,Xtest);
        
        acc(k, t) = sum(label == Ytest)/length(Ytest); % Store accuracy
        
        
    end
    
end

acc = mean(acc);

end