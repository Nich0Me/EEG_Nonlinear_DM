clear all
close all

addpath('./Functions')

% load ./RSA_Results/RSA_Subtraction_Results.mat
 load ./RSA_Results/RSA_Addition_Results


input = vector_acc-0.5; % Subtract the chance level

per_clustmass =[];

% Find clusters
[clustmass, cluster] = findClusters(input);

% Shuffle the input and find clusters
per_clustmass =[];
for permu = 1:10000

        idx = randperm(201,201);
        for k = 1:300
            Perm_vec(k,:) = vector_acc(k,idx)-0.5;
        end


    [n_clustmass, ~] = findClusters(Perm_vec);
    per_clustmass = [per_clustmass; n_clustmass(:,1)];
end

% Sort the random clusters
per_clustmass = sort(per_clustmass);

% Calculate pvalue per cluster
for k = 1:size(clustmass,1)
    idx = find(clustmass(k,1) < per_clustmass,1);
    if isempty(idx)
        idx = length(per_clustmass);
    end
    clustmass(k,3) = 1-idx/length(per_clustmass);
end

%% Plot Significant clusters
figure
plot(-0.5:0.01:1.5, mean(vector_acc-0.5,1),'k')
ylabel('accuracy')
xlabel('time')
hold on
time = -0.5:0.01:1.5;
if length(find(clustmass(:,3) < 0.02)) == 1
    c = time(logical((cluster == find(clustmass(:,3) < 0.02))));
else
    c = time(logical(sum(cluster == find(clustmass(:,3) < 0.02))));
end
plot(c,0.03,'*k')
xlim([-0.1, 1.5])
