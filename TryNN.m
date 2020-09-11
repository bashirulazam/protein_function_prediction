clear all
close all
clc

load('MyZ.mat');
load('data_xy.mat');
data = abs(Z);
label = y(:,[3,7,12])';
test_range = 3601:4500;
test_data = data(:,test_range);
%Training Neural Network
%initialize weights 
%load('NNweights.mat');
 %net = MyNeuralNet(data,label,wb);
load('NeuralNet.mat');
test_predicted = net(test_data);
test_true_label = label(:,test_range);
test_predicted = test_predicted(:);

test_predicted_label(test_predicted <=mean(test_predicted)) = 0;
test_predicted_label(test_predicted >mean(test_predicted)) = 1;
test_true_label = test_true_label(:)';
test_predicted_label = logical(test_predicted_label);
xnor_label = ~xor(test_true_label,test_predicted_label);
accuracy = sum(xnor_label)/length(xnor_label);
[precision,recall,F1] = Calc_F1(test_true_label,test_predicted_label);