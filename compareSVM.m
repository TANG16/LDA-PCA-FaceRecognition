function correct = compareSVM(coeff, vectorL, LBP, pcaLength)

svmW = [];
svmW0 = [];
for i = 1:7:105
    [w, w0] = faceSVM(i, coeff, pcaLength);
    svmW = [svmW; w];
    svmW0 = [svmW0, w0];
end

imgPath = 'test/';
imgType = '*.gif'; % change based on image type
images  = dir([imgPath imgType]);
correct = 0;
currImg = 1;
count = 1;
for i = 1:length(images)
    images(i).name;
    temp = imread([imgPath images(i).name]);
        temp = temp(:,70:280); %cuts off borders

    [n,m] = size(temp);
    y = [];
    if(LBP == 0)
        for j = 1:n
            y = [y, temp(j,:)];
        end
    else
        y = computeLBP(temp);
    end
    imgCoeff = double(y)*vectorL;
    imgCoeff = imgCoeff';
    top=1;
    out = 0;
    outTop = 0;
    for k=2:15
        out = svmW(k,:)*imgCoeff+svmW0(k);
        outTop = svmW(top,:)*imgCoeff+svmW0(top);
        if (out>outTop)
            top=k;
        end
    end
    top;
    currImg;
    outTop;
    if(top == currImg)
    %if(outTop < 0)
        correct = correct+1;
    end
    count = count + 1;
    if(count >= 5)
        currImg = currImg + 1;
        count = 1;
    end
end
'total correct = ';
correct;


end