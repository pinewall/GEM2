%% Read physcial variable data in pine's convension
%   NOTE: Output anlges are in radian form!!

%%
function [center_lats, center_lons, flux_value, nlats, nlons] = netcdf_read_field_v2(filename)

    % Open netCDF example file.
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
    
    varid = netcdf.inqVarID(ncid,'physical_variable');
    flux_value_1d = netcdf.getVar(ncid,varid);
    netcdf.close(ncid);

    %TODO: reshape could simplify code
    %center_lats=ones(nlons,nlats);
    %center_lons=ones(nlons,nlats);
    %flux_value=ones(nlons,nlats);
    %for i = 1:nlons
    %    start = (i - 1) * nlats + 1;
    %    center_lats(i,:)=center_lats_1d(start:start+nlats-1);
    %    center_lons(i,:)=center_lons_1d(start:start+nlats-1);
    %    flux_value(i,:)=flux_value_1d(start:start+nlats-1); 
    %end
    center_lats=reshape(center_lats_1d,nlons,nlats);
    center_lons=reshape(center_lons_1d,nlons,nlats);
    flux_value=reshape(flux_value_1d,nlons,nlats);
end