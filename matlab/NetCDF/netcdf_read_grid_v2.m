%% Read grid topology data in pine's convension
%   NOTE: Output anlges are in radian form!!

%%
function [center_lats, center_lons, imasks, nlats, nlons] = netcdf_read_grid_v2(filename)

    % Open netCDF example file.
    %disp(filename);
    ncid = netcdf.open(filename,'NC_NOWRITE');

    % Retrieve identifier of dimension.
    %dimid = netcdf.inqDimID(ncid,'grid_rank');
    %[dimname, grid_rank] = netcdf.inqDim(ncid,dimid);

    % Retrieve identifier of variables
    varid = netcdf.inqVarID(ncid,'grid_dims');
    grid_dims = netcdf.getVar(ncid,varid);
    nlons=grid_dims(1);
    nlats=grid_dims(2);

    varid = netcdf.inqVarID(ncid,'grid_center_lat');
    center_lats_1d = netcdf.getVar(ncid,varid);
    units=netcdf.getAtt(ncid,varid,'units');
    if strcmp(units(1:7),'degrees')
        center_lats_1d = center_lats_1d * pi / 180;
    end
    
    varid = netcdf.inqVarID(ncid,'grid_center_lon');
    center_lons_1d = netcdf.getVar(ncid,varid);
    units=netcdf.getAtt(ncid,varid,'units');
    if strcmp(units(1:7),'degrees')
        center_lons_1d = center_lons_1d * pi / 180;
    end
    
    varid = netcdf.inqVarID(ncid,'grid_imask');
    imasks_1d = netcdf.getVar(ncid,varid);
    netcdf.close(ncid);
    
    center_lats = reshape(center_lats_1d,nlons,nlats);
    center_lons = reshape(center_lons_1d,nlons,nlats);
    imasks = reshape(imasks_1d,nlats,nlons);
    
end