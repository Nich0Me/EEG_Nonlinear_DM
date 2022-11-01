clear all
close all

addpath('./Functions')

% load ./RSA_Results/Bad_Add_RSA_Results.mat
% load ./RSA_Results/Good_Add_RSA_Results.mat
% load ./RSA_Results/Bad_Sub_RSA_Results.mat
% load ./RSA_Results/Good_Sub_RSA_Results.mat

[Outcome,~]= FindDesignMatrix('Sub_Distance');

% Select time points between -200 and 1500 msec
input1 = vector_acc(Outcome==1,:);
input2 = vector_acc(Outcome==2,:);

per_clustmass =[];

% Find clusters
[clustmass, cluster] = findClusters_2Samples(input1, input2);

per_clustmass =[];
for permu = 1:1000


    idx1 = randperm(201,201);
    Perm_vec1 = vector_acc(Outcome==1,idx1);
    idx2 = randperm(201,201);
    Perm_vec2 = vector_acc(Outcome==2,idx2);


    [n_clustmass, ~] = findClusters_2Samples(Perm_vec1, Perm_vec2);
    if ~isempty(n_clustmass)
        per_clustmass = [per_clustmass; n_clustmass(:,1)];
    end

end

per_clustmass = sort(per_clustmass);

for k = 1:size(clustmass,1)
    idx = find(clustmass(k,1) < per_clustmass,1);
    if isempty(idx)
        idx = length(per_clustmass);
    end
    tail1 = 1-idx/length(per_clustmass);
    tail2 = idx/length(per_clustmass);
    clustmass(k,3) = min(tail1,tail2);
end

%% Plot Significant clusters
figure
plot(-0.5:0.01:1.5, mean(vector_acc(Outcome==1,:),1),'color',[0,180,216]./255, 'LineWidth',2)
hold on
plot(-0.5:0.01:1.5, mean(vector_acc(Outcome==2,:),1),'color',[255,158,0]./255, 'LineWidth',2)
ylabel('accuracy')
xlabel('time')
hold on
time = -0.5:0.01:1.5;
xlim([-0.1, 1.5])

if isempty(clustmass)
    disp('None')
elseif sum(clustmass(:,3) < 0.025) >1
    c = time(logical(sum(cluster == find(clustmass(:,3) < 0.025))));
    plot(c,0.56,'*k')
elseif sum(clustmass(:,3) < 0.025) ==1
    c = time(logical((cluster == find(clustmass(:,3) < 0.025))));
    plot(c,0.56,'*k')
elseif sum(clustmass(:,3) < 0.025) ==0
    disp('None')
end