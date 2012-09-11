% example of Generate_Field
function V = Check_Batch_Field(fstring)

    FieldPath='D:\MATLAB\R2011b\wks\Data\fields\';
    RealDataPath='D:\MATLAB\R2011b\wks\Data\flux-0612\';
    grid_name_list = {'T42','ll2.5','ll1','ll0.5','gamil'};

    for i = 1:size(grid_name_list,2)
        fieldname=strcat(FieldPath,grid_name_list(i),'.',fstring,'.nc');
        regrid_distribution(fieldname{1},'nlatnlon','realdata');
        title(grid_name_list(i));
        pause(2);
    end
    if ~strcmp(fstring,'Y2_2') && ~strcmp(fstring,'Y16_32')
        datafile=strcat(RealDataPath,'avXa2c_a_Faxa_',fstring,'.nc');
        regrid_distribution(datafile,'nlatnlon','realdata');
        title('real distribution');
    end
    V = 0;
end