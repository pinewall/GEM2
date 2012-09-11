% SCRIP grid cells supported by create_latlon.f

function [lat,lon] = Generate_SCRIP_LatLon(nlat,nlon) 
dlat = 180 / nlat;
dlon = 360 / nlon;

count1 = [0:nlat-1];
count2 = [1:nlat];
minlat = -90 + dlat * count1;
maxlat = -90 + dlat * count2;
centerlat = (minlat + maxlat) / 2;

count3 = [0:nlon-1];
count4 = [1:nlon];
centerlon = dlon * count3;
minlon = centerlon - dlon/2;
maxlon = centerlon + dlon/2;

[lat,lon] = meshgrid(centerlat,centerlon);
lat = deg2rad(lat);
lon = deg2rad(lon);

end