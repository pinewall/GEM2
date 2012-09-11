% example of Generate_Field
function V = Generate_Batch_Field(fstring,draw)
    V = 1;
    GridPath='D:\MATLAB\R2011b\wks\Data\grids\';
    FieldPath='D:\MATLAB\R2011b\wks\Data\fields\';
    RealDataPath='D:\MATLAB\R2011b\wks\Data\flux-0612\';
    
    grid_name_list = {'T42','ll2.5','ll1','ll0.5','gamil'};
    method = 'spline';

    if strcmp(fstring,'Y2_2') || strcmp(fstring,'Y16_32')
        for i = 1:size(grid_name_list,2)
            cdf_grid=strcat(GridPath,grid_name_list(i),'.nc');
            cdf_out=strcat(FieldPath,grid_name_list(i),'.',fstring,'.nc');
            Generate_Analytical_Field(cdf_grid{1}, cdf_out{1}, fstring, draw);
        end
    elseif strcmp(fstring,'lwdn') || strcmp(fstring,'rainl') || strcmp(fstring,'rainc') ||  ...,
            strcmp(fstring,'snowl') || strcmp(fstring,'snowc') || strcmp(fstring,'swndf') || ...,
            strcmp(fstring,'swndr') || strcmp(fstring,'swnet') || strcmp(fstring,'swvdf') || ...,
            strcmp(fstring,'swvdr')
        for i = 1:size(grid_name_list,2)
            cdf_fieldin=strcat(RealDataPath,'avXa2c_a_Faxa_',fstring,'.nc');
            cdf_grid=strcat(GridPath,grid_name_list(i),'.nc');
            cdf_fieldout=strcat(FieldPath,grid_name_list(i),'.',fstring,'.nc');
            Generate_Simulated_Field(cdf_fieldin,cdf_grid{1},cdf_fieldout{1},method,draw);
        end
    else
        disp('fstring input is not legal');
        disp('analytical: Y2_2 & Y16_32');
        disp('simulation: lwdn & rainl');
        return;
    end
    V = 0;
end