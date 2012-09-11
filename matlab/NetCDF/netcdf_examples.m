%% example to use netcdf interface

% Open netCDF example file.
ncid = netcdf.open('foo.nc','NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);

% Retrieve identifier of dimension.
dimid = netcdf.inqDimID(ncid,'grid_size');
[dimname, dimlen] = netcdf.inqDim(ncid,dimid);
grid_size=dimlen

dimid = netcdf.inqDimID(ncid,'nlats');
[dimname, dimlen] = netcdf.inqDim(ncid,dimid);
nlats=dimlen

dimid = netcdf.inqDimID(ncid,'nlons');
[dimname, dimlen] = netcdf.inqDim(ncid,dimid);
nlons=dimlen

% Retrieve identifier of variables
varid = netcdf.inqVarID(ncid,'grid_center_lat');
grid_center_lat = netcdf.getVar(ncid,varid);

varid = netcdf.inqVarID(ncid,'grid_center_lon');
grid_center_lon = netcdf.getVar(ncid,varid);

varid = netcdf.inqVarID(ncid,'physical_variable');
physical_variable = netcdf.getVar(ncid,varid);
netcdf.close(ncid);