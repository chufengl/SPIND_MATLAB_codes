%"com_compare.m" compares the Ori_matrix from different pairs of spots and
%find the common orientaiton solutions.

function [com_Ori]=com_compare(Ori_matrix1,Ori_matrix2,thld)

size_com_Ori=max([size(Ori_matrix1,1),size(Ori_matrix2,1)]);

com_Ori=zeros(size_com_Ori,8);

row_counter=1;
for l=1:size(Ori_matrix1,1)
    Ori1=Ori_matrix1(l,7:9);
    [row]=find((Ori_matrix2(:,7)<=(Ori1(1)+thld))&(Ori_matrix2(:,7)>=(Ori1(1)-thld))&...
        (Ori_matrix2(:,8)<=(Ori1(2)+thld))&(Ori_matrix2(:,8)>=(Ori1(2)-thld))&...
        (Ori_matrix2(:,9)<=(Ori1(3)+thld))&(Ori_matrix2(:,9)>=(Ori1(3)-thld)));
    for k=1:size(row,1)
        com_Ori(row_counter,:)=[l,Ori1,row(k),Ori_matrix2(row(k),7:9)];
        row_counter=row_counter+1;
    end
end
com_Ori=com_Ori(1:(row_counter-1),:);

end