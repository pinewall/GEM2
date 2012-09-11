%% Read physcial variable data in pine's convension
%   NOTE: Output anlges are in radian form!!

%%
function [center_lats, center_lons, flux_value, nlats, nlons] = netcdf_read_field(filename)

    % Open netCDF example file.
    ncid = netcdf.open(filename,'NC_NOWRITE');

    % Retrieve identifier of dimension.
    dimid = netcdf.inqDimID(ncid,'nlats');
    [dimname, nlats] = netcdf.inqDim(ncid,dimid);
    dimid = netcdf.inqDimID(ncid,'nlons');
    [dimname, nlons] = netcdf.inqDim(ncid,dimid);

    % Retrieve identifier of variables
    varid = netcdf.inqVarID(ncid,'grid_center_lat');
    center_lats = netcdf.getVar(ncid,varid);
    units=netcdf.getAtt(ncid,varid,'units');
    if strcmp(units(1:7),'degrees')
        center_lats = center_lats * pi / 180;
    end
    
    varid = netcdf.inqVarID(ncid,'grid_center_lon');
    center_lons = netcdf.getVar(ncid,varid);
    units=netcdf.getAtt(ncid,varid,'units');
    if strcmp(units(1:7),'degrees')
        center_lons = center_lons * pi / 180;
    end
    varid = netcdf.inqVarID(ncid,'physical_variable');
    flux_value = netcdf.getVar(ncid,varid);
    netcdf.close(ncid);
    
end