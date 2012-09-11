% simple plot for source grid and destination grid
function V =  BasicRectanglarGridsDraw(src_nlat,src_nlon,src_color,dst_nlat,dst_nlon,dst_color)
[src_lat,src_lon] = Generate_SCRIP_LatLon(src_nlat,src_nlon);
[dst_lat,dst_lon] = Generate_SCRIP_LatLon(dst_nlat,dst_nlon);
plot(src_lon,src_lat,src_color,dst_lon,dst_lat,dst_color);
V=0;
