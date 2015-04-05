function [coeff, vectorL] = myPCA(x, pcaLength)
    C=x'*x;
    [vectorC,valueC]=eig(C);
    ss=diag(valueC);
    [ss,iii]=sort(-ss);
    vectorC=vectorC(:,iii);
    vectorL=x*vectorC(:,1:pcaLength);
    coeff = x'*vectorL;
    coeff = coeff';
end