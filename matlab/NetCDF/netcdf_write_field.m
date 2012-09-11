%% Read physcial variable data in pine's convension

function V = netcdf_write_field(output,thetaX,phiX,units,valueX,maskX, nlat_out, nlon_out)

%% dump data on new grid
ncid = netcdf.create(output,'CLOBBER');

    % write dimension info
    dimid(1) = netcdf.defDim(ncid,'grid_size',nlat_out*nlon_out);
    dimid(2) = netcdf.defDim(ncid,'nlons',nlon_out);
    dimid(3) = netcdf.defDim(ncid,'nlats',nlat_out);
    vardimid = dimid(2:3);
    vardim = [nlon_out,nlat_out];

    % write variable info
    if strcmp(units,'deg')
        units_out = 'degrees';
    else
        units_out = 'radians';
    end
    varid(1) = netcdf.defVar(ncid,'grid_center_lat','double',vardimid);
    netcdf.putAtt(ncid,varid(1),'units','degrees north');
    varid(2) = netcdf.defVar(ncid,'grid_center_lon','double',vardimid);
    netcdf.putAtt(ncid,varid(2),'units','degrees east');
    varid(3) = netcdf.defVar(ncid,'grid_imask','int',vardimid);
    varid(4) = netcdf.defVar(ncid,'physical_variable','double',vardimid);

    % write global info
    gID=netcdf.getConstant('GLOBAL');
    netcdf.putAtt(ncid,gID,'creation_date',datestr(now));
    netcdf.putAtt(ncid,gID,'author&tool','pinewall@matlab 2011b');
    netcdf.putAtt(ncid,gID,'convension','SCRIP');

    % exit define mode & write data
    netcdf.endDef(ncid);
    netcdf.putVar(ncid,varid(1),[0,0],vardim,thetaX);
    netcdf.putVar(ncid,varid(2),[0,0],vardim,phiX);
    netcdf.putVar(ncid,varid(3),[0,0],vardim,maskX);
    netcdf.putVar(ncid,varid(4),[0,0],vardim,valueX);
    netcdf.close(ncid);
    V = 0;
    disp('Generate netCDF Successfully');
    
end