pcaLength = 100;

imgPath = 'yalefaces/';
imgType = '*.gif'; % change based on image type
images  = dir([imgPath imgType]);
x= [];
for i = 1:length(images)
    images(i).name;
    temp = imread([imgPath images(i).name]);
    temp = temp(:,70:280); %cut off edges
    

    %imshow(temp)
    %pause(.1)
    %temp = rgb2gray(temp);
    [n,m] = size(temp);
    y = [];
    for j = 1:n
        y = [y, temp(j,:)];
    end
    x = [x; y];
end
x = cast(x, 'double');
x = x';
[coeff, vectorL] = myPCA(x, pcaLength);

classAvgs = [];
classNum = 1;
for i=1:7:105 %for all images
    for j=0:6 %for each class
        temp = zeros(pcaLength,1);
        for d=1:pcaLength
            temp(d) = temp(d) + coeff(d, i+j)*(1/7);
        end
    end
    classAvgs = [classAvgs, temp];
    classNum = classNum + 1;
end


svm = compareSVM(coeff, vectorL, 0, pcaLength)
avg = compareAvgs(classAvgs, vectorL, 0)
vecL = myLDA(coeff, pcaLength);
LDAavg = compareLDAAvgs(classAvgs, vectorL,vecL, 0)

