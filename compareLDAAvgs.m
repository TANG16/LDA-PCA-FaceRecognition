function correct = compareLDAAvgs(classAvgs, vectorL, FDAvec, LBP)

imgPath = 'test/';
imgType = '*.gif'; % change based on image type
images  = dir([imgPath imgType]);
correct = 0;
currImg = 1;
count = 1;
for i = 1:length(images)
    images(i).name;
    temp = imread([imgPath images(i).name]);
        temp = temp(:,70:280); %cuts off edges

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
    imgCoeff = imgCoeff * FDAvec;
    imgCoeff = imgCoeff';
    top=1;
    for k=2:15
        if (norm((classAvgs(:,k)*FDAvec')-imgCoeff,1)<norm((classAvgs(:,top)*FDAvec')-imgCoeff,1))
            top=k;
        end
    end
    images(i).name;
    'is class';
    top;
    currImg;
    if(top == currImg)
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