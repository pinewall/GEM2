% Reference: http://blog.163.com/dingkediling@126/blog/static/6161300720091018112144480/

function [Re,Im] = SphericalHarmonicL(l,theta,phi)

if l == 0
    Re(1,:,:)=ones(size(theta));
    Im(1,:,:)=zeros(size(theta));
else
    pl=legendre(l,cos(theta));      %计算勒让德函数的值

    for m = 1:l+1
        plm(:,:)=pl(m,:,:);
        Re(m,:,:)=cos(m*phi).*plm(:,:);      %实球谐函数
        Im(m,:,:)=sin(m*phi).*plm(:,:);      %虚球谐函数
    end
end


