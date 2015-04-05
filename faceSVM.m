function [w, w0] = faceSVM(classLoc, coeff, pcaLength)

n = 105;

y = -1*ones(n,1);
y(classLoc:(classLoc+6)) = 1;

H = eye(pcaLength+1+n);

H = eye(pcaLength+1+n);
H(pcaLength+1:end,pcaLength+1:end) = 0;
C=0.001;
f = C*ones(pcaLength+1+n,1);
f(1:pcaLength+1) = 0;
A = diag(y)*[coeff' ones(n,1)];
A = -1*[A eye(n)];
b = -1 * ones(n, 1);
lb = [-inf(1,pcaLength+1), zeros(1,n)];
neww = quadprog(H, f, A, b, [], [], lb, [], []);
w = zeros(pcaLength,1);
for i=1:1:pcaLength
    w(i) = neww(i);
end
w0 = neww(pcaLength+1);
w = w';
end