function [clustmass, cluster] = findClusters(input)
%% This function takes accuracy as input and outputs clusters.
%% Clustmass is an Nx2 matrix where N is the number of clusters found. The
%% first column is the sum of the t-values per cluster. The second column is
%% the number of the cluster
%% Cluster is a vector indicating the time points of the clusters

% Perform a ttest
[~,~,~,stat] = ttest(input);

% Find all the t-values over 2
tval = stat.tstat > 2;
% Find clusters bigger than 2 consecutive points
min_time = 1;

cluster = zeros(1,size(tval,2));
clust_idx = 1;

% Find and number clusters
for t = 2:size(input,2)-min_time-1

    if tval(t) == 1 & sum(tval(t:t+min_time)) == min_time+1 & tval(t-1) == 0
        pos_in = t;

        while tval(t)==1 & t < size(input,2)-1
            t = t+1;
        end
        pos_end =t-1;

        cluster(pos_in:pos_end) = clust_idx;
        clust_idx = clust_idx+1;
    end

end

% Create clustmass containing the number of the cluster and the sum of the
% t-values

for k = 1:max(cluster)
    idx = find(cluster==k);
    clustmass(k,1) = sum(stat.tstat(idx));
    clustmass(k,2) = k;
end

if ~exist('clustmass')
    clustmass = [];
end

end