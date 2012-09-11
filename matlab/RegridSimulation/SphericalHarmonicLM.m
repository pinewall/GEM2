% Reference: http://blog.163.com/dingkediling@126/blog/static/6161300720091018112144480/

function [Re,Im] = SphericalHarmonicLM(l,m,theta,phi)

if l < m
    disp('l must be not less than m')
    return
elseif l == 0
    Re(1,:,:)=ones(size(theta));
    Im(1,:,:)=zeros(size(theta));
else
    pl=legendre(l,cos(theta));      %计算勒让德函数的值
    plm(:,:)=pl(m+1,:,:);
    Re=cos(m*phi).*plm;      %实球谐函数
    Im=sin(m*phi).*plm;      %虚球谐函数
end





