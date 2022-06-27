clear ;
clc ;
%---------------------------
disp('Loading output_rtl...') ;
output_rtl_id = fopen('output_rtl.txt') ;
output_rtl = textscan(output_rtl_id,'%c');
output_rtl = cell2mat(output_rtl) ;
output_rtl = reshape(output_rtl,[32,50176]);
output_rtl = output_rtl.' ;
disp('Loading output_sv...') ;
output_sv_id = fopen('output_sv.txt') ;
output_sv = textscan(output_sv_id,'%c');
output_sv = cell2mat(output_sv) ;
output_sv = reshape(output_sv,[32,50176]);
output_sv = output_sv.' ;
disp('Start testing...') ;

%---------------------------
error_counter = 0 ;
for ii = 1:1:50176
    error_cnt = 0 ;
    for jj = 1:1:32
        if(output_rtl(ii,jj)~=output_sv(ii,jj))
             error_cnt = error_cnt + 1 ;
        end
    end
    if(error_cnt>0)
        disp(['line ',int2str(ii),' error occur!']) ;
    end
    error_counter = error_counter + error_cnt ;
    if(mod(ii,10000)==0)
        disp(['---line ',int2str(ii),' testing done---']) ;
    end
end
disp('=====All lines testing done=====') ;
disp(['There are (',int2str(error_counter),') errors.']) ;
fclose(output_rtl_id) ;
fclose(output_sv_id) ;







