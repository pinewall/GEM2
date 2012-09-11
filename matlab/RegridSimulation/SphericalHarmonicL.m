% Reference: http://blog.163.com/dingkediling@126/blog/static/6161300720091018112144480/

function [Re,Im] = SphericalHarmonicL(l,theta,phi)

if l == 0
    Re(1,:,:)=ones(size(theta));
    Im(1,:,:)=zeros(size(theta));
else
    pl=legendre(l,cos(theta));      %�������õº�����ֵ

    for m = 1:l+1
        plm(:,:)=pl(m,:,:);
        Re(m,:,:)=cos(m*phi).*plm(:,:);      %ʵ��г����
        Im(m,:,:)=sin(m*phi).*plm(:,:);      %����г����
    end
end


