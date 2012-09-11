% regrid simulation with gridInterpolant
function V = GriddedSimulation_example(ndeg,fluxsname)
    % modified items
    %ndeg = 0.5;
    %fluxsname='rainl';

    if int8(ndeg) == ndeg
        ndegstr=int2str(ndeg);
    else
        ndegstr=num2str(ndeg,2);
    end
    GridPath='D:\MATLAB\R2011b\wks\Data\grids\';
    FieldPath='D:\MATLAB\R2011b\wks\Data\fields\';
    RealDataPath='D:\MATLAB\R2011b\wks\Data\flux-0612\';
    input=strcat(RealDataPath,'\avXa2c_a_Faxa_',fluxsname,'.nc');
    output=strcat(FieldPath,fluxsname,'_',ndegstr,'deg.nc');
    nlat_output = 180/ndeg;
    nlon_output = 360/ndeg;
    method='spline';
    draw=0;

    %GriddedSimulation('foo.nc','lwd_1deg.nc',180,360,'spline',0)
    GriddedSimulation(input,output,nlat_output,nlon_output,method,draw)

    % draw simulated data
    regrid_distribution(output,'nlatnlon','realdata')
    axis([-eps 2*pi+eps -pi/2-eps pi/2+eps]);
    xlabel('longitude');
    ylabel('latitude');
    title(strcat(fluxsname,'\_',ndegstr,'deg'));

    figname=strcat('D:\MATLAB\R2011b\wks\RegridSimulation\figure\',fluxsname,'-',ndegstr,'deg.jpg');
    print('-djpeg','-r300',figname);

    V = 0;
end