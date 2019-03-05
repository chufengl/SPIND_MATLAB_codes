% "stream_out.m" output the ASCII file as the result of sparse indexing
% module.

function [] = stream_out(lp,folder,PATH)


oldfolder=cd(folder);
%load the solution data file "cxi...fileterd.mat" in each run.
%------------------------------
list=dir(['I3C*edge',num2str(lp(4)),'filtered.mat']);
name=list.name;
load(name);
%------------------------------

%PATH='/Users/chufeng/Desktop';
stream_file=fullfile(PATH,['I3C_1C_Zn_edge_',num2str(lp(4)),'.stream']);
fileID=fopen(stream_file,'w');
fprintf(fileID,'\n\n\n\nOutput stream file using sparse indexing algorithm.\n\n');
fprintf(fileID,'I3C_1C_Zn_edge');
fprintf(fileID,'\n\n\n\n indexing rate=%5.2f (%5.2f after filtering)\n\n\n\n',index_rate,com_counter/end_id);

for l=1:size(abc_star_out,2)
    if abc_star_out(l).com_success==1
        fprintf(fileID,'\n\n----- Begin chunk -----\n');
        fprintf(fileID,['Event: //',num2str(abc_star_out(l).event_id),'\n']);
        
        for m=1:size(abc_star_out(l).Ori_matrix,2)
            
            
            fprintf(fileID,['\n\n-----Begin solution',num2str(m),'-----\n']);
            
            %---------------------------------------------------------Ori_matrix.
            fprintf(fileID,'astar = %+10f %+10f %+10f nm^-1\n',10*abc_star_out(l).Ori_matrix{1,m}(:,1));
            fprintf(fileID,'bstar = %+10f %+10f %+10f nm^-1\n',10*abc_star_out(l).Ori_matrix{1,m}(:,2));
            fprintf(fileID,'cstar = %+10f %+10f %+10f nm^-1\n',10*abc_star_out(l).Ori_matrix{1,m}(:,3));
            %---------------------------------------------------------
            
            %-----------------------------------------------indexing list
            [peak_c_list] = peak_list_conv(['I3C_1C_Zn_edge',num2str(abc_star_out(l).event_id),'.txt'],0.07,110);
            fprintf(fileID,'%4s %4s %4s %10s %10s %10s %6s\n','h','k','l','I','y/px','x/px','match');
            fprintf(fileID,'%4d %4d %4d %10.2f %10.2f %10.2f %6d\n',...
                [abc_star_out(l).pm_list{1,m}(:,7:9).';peak_c_list(:,3).';-peak_c_list(:,1).';peak_c_list(:,2).';abc_star_out(l).pm_list{1,m}(:,19).']);
            fprintf(fileID,['-----End solution',num2str(m),'-----\n']);
            %---------------------------------------------------------
            
            
        end
       fprintf(fileID,'\n----- End chunk -----\n\n\n\n\n'); 
        
        
    end

end




fclose(fileID);
cd(oldfolder);
end
