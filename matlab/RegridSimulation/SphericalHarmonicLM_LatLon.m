function [Re,Im] = SphericalHarmonicLM_LatLon(l,m,nlat,nlon)

deltalat=pi/nlat;
deltalon=pi/nlon;
theta0=-pi/2:deltalat:pi/2;
phi0=0:2*deltalon:2*pi;
[phi,theta]=meshgrid(phi0,theta0);  %构造θφ数据网络
[Re,Im]=SphericalHarmonicLM(l,m,theta,phi);

end