function V = GriddedSimulation(input,output,nlat_out,nlon_out,method,draw)

%nlat = 90;
%nlon = 180;
%input='foo.nc'
%output='lwd_2.5deg.nc';
%method='spline'
V = 1;

% load realdata and generate simulation function F
[theta, phi, value, nlat_in, nlon_in] = netcdf_read_field(input);
F=griddedInterpolant(theta',phi',value',method);

% generate grid center coordinates
[thetaX,phiX] = Generate_SCRIP_LatLon(nlat_out,nlon_out);

%[thetaX,phiX]=ndgrid(-80:0.5:80,0:0.5:350);

% calculate value at new coordinates
valueX=F(thetaX',phiX');

%% draw
if draw == 1
    mesh(phiX,thetaX,valueX')
end

%% dump data on new grid
ncid = netcdf.create(output,'CLOBBER');

% write dimension info
dimid(1) = netcdf.defDim(ncid,'grid_size',nlat_out*nlon_out);
dimid(2) = netcdf.defDim(ncid,'nlons',nlon_out);
dimid(3) = netcdf.defDim(ncid,'nlats',nlat_out);
vardim = dimid(2:3);

% write variable info
units_out = 'degrees';
varid(1) = netcdf.defVar(ncid,'grid_center_lat','double',vardim);
netcdf.putAtt(ncid,varid(1),'units',units_out);
varid(2) = netcdf.defVar(ncid,'grid_center_lon','double',vardim);
netcdf.putAtt(ncid,varid(2),'units',units_out);
varid(3) = netcdf.defVar(ncid,'grid_imask','int',vardim);
varid(4) = netcdf.defVar(ncid,'physical_variable','double',vardim);

% write global info
gID=netcdf.getConstant('GLOBAL');
netcdf.putAtt(ncid,gID,'creation_date',datestr(now));
netcdf.putAtt(ncid,gID,'author&tool','pinewall@matlab 2011b');
netcdf.putAtt(ncid,gID,'convension','SCRIP');

% exit define mode & write data
netcdf.endDef(ncid);
netcdf.putVar(ncid,varid(1),[0,0],[nlon_out,nlat_out],thetaX);
netcdf.putVar(ncid,varid(2),[0,0],[nlon_out,nlat_out],phiX);
netcdf.putVar(ncid,varid(3),[0,0],[nlon_out,nlat_out],ones(nlon_out,nlat_out));
netcdf.putVar(ncid,varid(4),[0,0],[nlon_out,nlat_out],valueX');
netcdf.close(ncid);
V = 0;
disp('Generate Successfully');
