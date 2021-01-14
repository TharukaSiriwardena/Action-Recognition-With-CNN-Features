function [rate,ind] = SVMclassify(N)
    % Train the data using SVM
    
    %load the .txt file into the new variable.
    %if we use .mat file it gives 1*1 struct file.It is troublism 
    trData = load('fetVectorTrain.txt');
    teData = load('fetVectorTest.txt');

    A = 1:N;
    %set of parameters
%     a = -15:15;
%     C = 2.^a;
    C = [2^-15,2^-14,2^-13,2^-12,2^-11,2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,1,2,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10,2^11,2^12,2^13,2^14,2^15,];
    accuracy = []; % initialize classification rate
    col = size(teData, 2); % this gives the column size of the teData matrix

    for i = 1:length(C)
        options = svmlopt('C',C(i),'Verbosity',1);%tell SVM to which kernel to use
        prediction = [];
	
        for class = 1:N
            Model = ['model' int2str(A(class)) 'vsAll'];% name of the model
            x = invertData(trData,A(class));
            y = x(:,col); %get the all rows of last column(label) in to Y
            x(:,col) = []; % initialze last column as empty
            svmlwrite('SVMLTrain',x,y);%preprocess the data to undestandable foemat of SVM Light
            svm_learn(options,'SVMLTrain',Model);% input(x)-->|f(x)|-->output(y)::indicate f(x) function

            Modeloutput = ['output' int2str(A(class)) 'vsAll'];
            xtest = invertData(teData,A(class));
            ytest = xtest(:,col);
            xtest(:,col) = [];
            svmlwrite('SVMLTest',xtest,ytest);
            svm_classify(options,'SVMLTest',Model,Modeloutput);
            svmpredict = svmlread(Modeloutput);
            prediction = [prediction svmpredict];

        end
	
        accuracy(i) = WinnerTakesAll(teData,prediction,A);
	
    end

    accuracy  %[0.7520    0.7920    0.8080    0.8320    0.8400    0.8480    0.8880    0.8880    0.8800    0.8800    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880  0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880    0.8880]
    [rate,ind] = max(accuracy); %rate = 0.8880 ind = 7
end
