function [result] = classification(training_feature_t,training_feature_c,...
    training_feature_r, training_feature_w, novel_feature)

%% size of the features
training_feature_t;
[r_t c_t] = size(training_feature_t') ;
[r_c c_c] = size(training_feature_c') ;
[r_r c_r] = size(training_feature_r') ;
[r_w c_w] = size(training_feature_w') ;


training_feature_cat = cat(1,training_feature_t',...
    training_feature_c',training_feature_r', training_feature_w');

[r_tf, c_tf] = size(training_feature_cat); 

%% Name the groups

Group(1:r_t,:) = {'Tango'};
Group(r_t+1:r_t+r_c,:) = {'Chachacha'};
Group(r_t+r_c+1:r_t+r_c+r_r,:) = {'Rumba'};
Group(r_t+r_c+r_r+1:r_t+r_c+r_r+r_w,:) = {'Waltz'};

size(Group); %3344 1
novel_feature = novel_feature'; 

size(novel_feature); %109,25
size(training_feature_cat); % 3344,25

%% apply k-NN

result_many = knnclassify(novel_feature, training_feature_cat, Group, 60);

%% pick the rhythm which appears for the most time

y = unique(result_many);
n = zeros(length(y), 1);
for iy = 1:length(y);
  n(iy) = length(find(strcmp(y{iy}, result_many)));
  
end
sumsum = sum(n(1:length(y)));
[~, itemp] = max(n);
n_max = n(itemp);
n(itemp) = 0;
[~, itemp2] = max(n);  %
n_max_2 = n(itemp2);

if (n_max - n_max_2) < 11 
    result = y(itemp) %
    percentage = n_max/sum(n_max+n_max_2)
    result_second = y(itemp2) %
    percentage2 = n_max_2/sum(n_max+n_max_2)
else
    result = y(itemp)
%     percentage = 
end









end