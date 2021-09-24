clc;

%load data
load 'spamData.mat'

%add bias
xb_train = ones(length(Xtrain),1);
xb_test = ones(length(Xtest),1);
xtrain = [xb_train Xtrain];
xtest = [xb_test Xtest];

%data preprocessing
xtrain = log_transform(xtrain);
xtest = log_transform(xtest);

%Regularization
k1 = 1:1:10;
k2 = 15:5:100;
lamda = [k1 k2];
I = eye(58);
I(1,1) = 0;

%Training stage
lr = 0.001;
iters = 15000;
w_saved = zeros(58,28);

pred_train = zeros(length(ytrain),28);
error_train = zeros(28,1);

pred_test = zeros(length(ytest),28);
error_test = zeros(28,1);

for i = 1:length(lamda)
    
    w = zeros(58,1);
    mu_train = (1 ./ (1+exp(-(xtrain * w))));
    g = xtrain' * (mu_train - ytrain);
    diag_elem = mu_train .* (1-mu_train);
    S = diag(diag_elem); 
    H = xtrain' * S * xtrain;
    
    g = g + lamda(i) .* w;
    H = H + lamda(i) .* I;
    
    for n = 1:iters
        w = w - lr .* (inv(H) * g);
    end
    
    w_saved(:,i) = w;
    
    pred_train(:,i) = compute_pred(xtrain,w);
    error_train(i,:) = compute_error(pred_train(:,i),ytrain);
    
    pred_test(:,i) = compute_pred(xtest,w);
    error_test(i,:) = compute_error(pred_test(:,i),ytest);
    
    
end

   
%plot
plot(lamda',error_train);
hold on
plot(lamda',error_test);
grid minor
legend("Train","Test")

xlabel("Lamda");
ylabel("Training/Testing Error")
title("Error rate over the change of lamda")










