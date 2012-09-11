%% example to use netcdf interface

function plot = regrid_distribution(filename, fileversion,peudo_function)

    % Get Latitudes, Longitudes and Flux values
    if strcmp(fileversion,'nlatnlon')
        [lat, lon, flux_value] = netcdf_read_field(filename);
    elseif strcmp(fileversion,'grid_dims')
        [lat, lon, flux_value] = netcdf_read_field_v2(filename);
    else
        disp('Only support nlatnlon and grid_dims');
        return
    end

    if strcmp(peudo_function, 'Y22')
        V = 2 + power(cos(lat),2) .* cos(2*lon);%SphericalHarmonicY(2,2,lat,lon);
        plot = mesh(lon,lat,V);
    elseif strcmp(peudo_function, 'realdata')
        V = flux_value;
        plot = mesh(lon,lat,V);
    end

end
