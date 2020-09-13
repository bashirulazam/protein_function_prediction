clear all
close all
clc

load('dataStruct.mat'); % all protein sequence
load('labelDictionary.mat'); % all keys
load('keysList.mat'); % Keys of proteinss having the selected GOs
n = length(listOfLabels);

all_keys = {sequenceStruct.keys};
all_labels = [8152, 97009, 3700, 6412, 9306,  ...
              19538,  7165, 6968,  4803,...
              1708, 32502, 30154];

for i = 1:n 
    keys = char(listOfLabels(i));
    idx = find(ismember(all_keys,keys));
    protein_seq = sequenceStruct(idx).Sequence;
    L = length(protein_seq);
    for l = 1:3:L-2
        alltrimers{1,(l+2)/3} = protein_seq(l:l+2);
    end
    
    [unique_trimers,IA,IC] = unique(alltrimers,'stable');
    tf(i,:) = zeros(20^3,1);
    for j = 1:length(unique_trimers)
        trimer = unique_trimers(j);
        position = calc_pos(trimer{1,1});
        tf(i,position) = sum(count(alltrimers,unique_trimers(j)));
    end
    ntf(i,:) = tf(i,:)/sum(tf(i,:));

    labelCell = labelDictionary(keys);
    labels = cell2mat(labelCell);
    y(i,:) = ismember(all_labels, labels);
end

temp = logical(tf);
df = sum(temp);
idf = log(n./(df+eps));

for i = 1:n
    x(i,:) = tf(i,:).*idf;
end
savefile = 'data_xy.mat';
save(savefile, 'x','y');