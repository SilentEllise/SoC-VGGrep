clear ;
clc ;
%---------------------------
weights = textread('weights.txt');
featureMap = textread('featureMap.txt');
fid = fopen('data_top_in.txt','w') ;
fm = reshape(featureMap,[112,112,32]) ;
%---------------------------
weights_bit = num2str(weights,'%08d') ;
%---------------------------
for ii = 1:1:200
    fprintf(fid,weights_bit(ii*4-3,:)) ;
    fprintf(fid,weights_bit(ii*4-2,:)) ;
    fprintf(fid,weights_bit(ii*4-1,:)) ;
    fprintf(fid,weights_bit(ii*4-0,:)) ;
    fprintf(fid,'\n') ;
end
%---------------------------
for batch = 1:1:8
    fm_part = fm(:,:,batch*4-3:batch*4) ;
    fm_part_p1 = fm_part(:,:,1) ;
    fm_part_p2 = fm_part(:,:,2) ;
    fm_part_p3 = fm_part(:,:,3) ;
    fm_part_p4 = fm_part(:,:,4) ;
    fm_part_p1 = reshape(fm_part_p1,[12544,1]) ;
    fm_part_p2 = reshape(fm_part_p2,[12544,1]) ;
    fm_part_p3 = reshape(fm_part_p3,[12544,1]) ;
    fm_part_p4 = reshape(fm_part_p4,[12544,1]) ;
    fm_part_p1_bit = num2str(fm_part_p1,'%08d') ;
    fm_part_p2_bit = num2str(fm_part_p2,'%08d') ;
    fm_part_p3_bit = num2str(fm_part_p3,'%08d') ;
    fm_part_p4_bit = num2str(fm_part_p4,'%08d') ;
    for addr = 1:1:12544
        fprintf(fid,fm_part_p1_bit(addr,:)) ;
        fprintf(fid,fm_part_p2_bit(addr,:)) ;
        fprintf(fid,fm_part_p3_bit(addr,:)) ;
        fprintf(fid,fm_part_p4_bit(addr,:)) ;
        fprintf(fid,'\n') ;
    end
end

%---------------------------
fclose(fid) ;





