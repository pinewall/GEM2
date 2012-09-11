%% Generate input_netcdf_file based on 
%   grid_netcdf_file and 
%   analytical function

%%
function V = Generate_Analytical_Field(cdf_grid, cdf_out, function_name,draw)

    %disp(cdf_in);
    %disp(cdf_out);
    [center_lats, center_lons, imasks, nlats, nlons] = netcdf_read_grid_v2(cdf_grid);
    
    if strcmp(function_name,'Y2_2')
        field = 2 + power(cos(center_lats),2) .* cos(center_lons * 2);
    elseif strcmp(function_name,'Y16_32')
        field = 2 + power(cos(center_lats),16) .* cos(center_lons * 16);
    else
        disp('Only support Y2_2 and Y16_32');
        return;
    end
    
    % draw
    if draw == 1
        mesh(center_lons,center_lats,field);
        pause(1);
    end
    
    % rad to deg
    center_lats = center_lats * 180 / pi;
    center_lons = center_lons * 180 / pi;  
    V = netcdf_write_field(cdf_out,center_lats, center_lons, 'deg',field, imasks, nlats, nlons);  
    disp('Generate Field Successfully');
end