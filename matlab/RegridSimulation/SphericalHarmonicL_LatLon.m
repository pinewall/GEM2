function [Re,Im] = SphericalHarmonicL_LatLon(l,nlat,nlon)

if l == 0
    Re(1,:,:)=ones(nlat,nlon);
    Im(1,:,:)=zeros(nlat,nlon);
else
    deltalat=pi/nlat;
    deltalon=pi/nlon;
    theta0=-pi/2:deltalat:pi/2;
    phi0=0:2*deltalon:2*pi;
    [phi,theta]=meshgrid(phi0,theta0);  %构造θφ数据网络
    [Re,Im]=SphericalHarmonicL(l,theta,phi);
end
end