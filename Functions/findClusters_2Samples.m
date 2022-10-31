function [clustmass, cluster] = findClusters_2Samples(input1, input2)
%% This function takes accuracy inputs of two different groups and outputs clusters.
%% Clustmass is an Nx2 matrix where N is the number of clusters found. The
%% first column is the sum of the t-values per cluster. The second column is
%% the number of the cluster
%% Cluster is a vector indicating the time points of the clusters

% Perform a ttest
[h,~,~,stat] = ttest2(input1,input2);

% Find all the t-values over 2 or lower than -2
pos_tval = stat.tstat > 2;
neg_tval = stat.tstat < -2;

% Find clusters bigger than 2 consecutive points
min_time = 2;

cluster = zeros(1,size(pos_tval,2));
clust_idx = 1;

% Find and number clusters
for t = 2:size(input1,2)-min_time-1

    if pos_tval(t) == 1 & pos_tval(t+min_time-1) == 1 & pos_tval(t-1) == 0
        pos_in = t;

        while pos_tval(t)==1 & t < size(input1,2)-1
            t = t+1;
        end
        pos_end =t-1;

        cluster(pos_in:pos_end) = clust_idx;
        clust_idx = clust_idx+1;
    end

end

for t = 2:size(input1,2)-min_time-1

    if neg_tval(t) == 1 & neg_tval(t+min_time-1) == 1 & neg_tval(t-1) == 0
        pos_in = t;

        while neg_tval(t)==1 & t < size(input1,2)-1
            t = t+1;
        end
        pos_end =t-1;

        cluster(pos_in:pos_end) = clust_idx;
        clust_idx = clust_idx+1;
    end

end

for k = 1:max(cluster)
    idx = find(cluster==k);
    clustmass(k,1) = sum(stat.tstat(idx));
    clustmass(k,2) = k;
end

if ~exist('clustmass')
    clustmass = [];
end
end