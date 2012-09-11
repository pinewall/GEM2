% Evalue Batch Regrid Errors

%function [mres1,ares1,rmses1,mres2,ares2,rmses2] = Evaluate_Batch_Field(fstring)
function [stat1,stat2] = Evaluate_Batch_Field(fstring)

    %testcase=[{'T42','ll2.5'};{'ll2.5','T42'};{'ll0.5','ll2.5'};{'ll2.5','ll1'};{'ll1','ll2.5'}];
    %testcase=[{'ll2.5','ll0.5'};{'ll2.5','ll1'}];
    testcase=[{'ll2.5','ll1'}];
    
    mres1=zeros(size(testcase,1),1);
    ares1=zeros(size(testcase,1),1);
    rmses1=zeros(size(testcase,1),1);
    mres2=zeros(size(testcase,1),1);
    ares2=zeros(size(testcase,1),1);
    rmses2=zeros(size(testcase,1),1);
    %size(testcase)
    
    for i = 1:size(testcase,1)
        src_grid_name=testcase{i,1};
        dst_grid_name=testcase{i,2};
        disp(strcat('(',src_grid_name,',',dst_grid_name,',',fstring,')'));
        [mres1(i),ares1(i),rmses1(i)] = Evaluate_Regrid_Errors(src_grid_name, dst_grid_name, fstring, 1, 0);
        [mres2(i),ares2(i),rmses2(i)] = Evaluate_Regrid_Errors(src_grid_name, dst_grid_name, fstring, 2, 0);
    end
    stat1=[mres1,ares1,rmses1];
    stat2=[mres2,ares2,rmses2];
end