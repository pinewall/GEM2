%% Evaluate remap errors

%%
function [max_relative_error,ave_relative_error,root_mean_square_error] = Evaluate_Regrid_Errors(src_grid_name, dst_grid_name, test_func_name, order, draw)
    
    max_relative_error = 0;
    ave_relative_error = 0;
    
    standard_field_path=strcat('D:\MATLAB\R2011b\wks\Data\fields\',dst_grid_name,'.',test_func_name,'.nc');
    if order == 1
        regrided_field_path=strcat('D:\MATLAB\R2011b\wks\Data\regridded_fields\', ...,
            dst_grid_name,'.',src_grid_name,'_',dst_grid_name,'.order1.',test_func_name,'.nc');
    elseif order == 2
        regrided_field_path=strcat('D:\MATLAB\R2011b\wks\Data\regridded_fields\', ...,
            dst_grid_name,'.',src_grid_name,'_',dst_grid_name,'.order2.',test_func_name,'.nc');
    else
        disp('order should BE 1 or 2');
        return;
    end
    [center_lats_std, center_lons_std, flux_value_std,nlats,nlons] = netcdf_read_field(standard_field_path);
    [center_lats_regrid, center_lons_regrid, flux_value_regrid] = netcdf_read_field_v2(regrided_field_path);
    error = flux_value_regrid  - flux_value_std;
    if draw == 1
        mesh(center_lats_std, center_lons_std,error);
        title(strcat('Error of Regridded Field between ',src_grid_name, ' and ', dst_grid_name));
        pause(2);
    end
    
    abserror=abs(error);
    if draw == 1
        mesh(center_lats_std, center_lons_std,abserror);
        title(strcat('Absolute Error of Regridded Field between ',src_grid_name, ' and ', dst_grid_name));
        pause(2);
    end
    
    relative_abserror = abs(error) ./ abs(flux_value_std);
    if draw == 1
        mesh(center_lats_std, center_lons_std,relative_abserror);
        title(strcat('Relative Absolute Error of Regridded Field between ',src_grid_name, ' and ', dst_grid_name));
    end
    max_relative_error = max(max(relative_abserror));
    ave_relative_error = sum(sum(relative_abserror)) / nlats / nlons;
    root_mean_square_error = sqrt(sum(sum(relative_abserror .* relative_abserror)) / nlats / nlons);
end