%% Generate input_netcdf_file based on 
%   grid_netcdf_file and 
%   analytical function

%%
function V = Generate_Simulated_Field(cdf_fieldin,cdf_grid,cdf_fieldout,method,draw)

    %method='spline'
    V = 1;

    % load realdata and generate simulation function F
    [theta, phi, value, nlat_in, nlon_in] = netcdf_read_field(cdf_fieldin);
    F=griddedInterpolant(theta',phi',value',method);

    % load grid info of output field
    [thetaX,phiX, imasks, nlat_grid, nlon_grid] = netcdf_read_grid_v2(cdf_grid);

    % calculate value at new coordinates
    valueX=F(thetaX',phiX');
    valueX=valueX';

    %% draw
    if draw == 1
        mesh(phiX,thetaX,valueX);
        pause(1);
    end

    %% dump data on new grid
    thetaX = rad2deg(thetaX);
    phiX = rad2deg(phiX);
    V = netcdf_write_field(cdf_fieldout,thetaX, phiX, 'deg',valueX, imasks, nlat_grid, nlon_grid); 
    disp('Generate Field Successfully');
end
