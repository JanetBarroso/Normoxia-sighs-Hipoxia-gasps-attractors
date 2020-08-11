function y=GaussianJB(x,a,b,c)
y = a .*exp(-((x-b)./c).^2);