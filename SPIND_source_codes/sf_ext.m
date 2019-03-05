% "sf_ext.m" extends the incomplete structure factor list to a complete one.


function [sf_list_ext] = sf_ext(NAME_sf,res,lp)

A=zeros(3);

%for orthorhombic lattice
%-------------------------------------------
%A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
%A(2,2)=1/lp(2)*sind(lp(6));
%A(3,3)=1/lp(3);
%-------------------------------------------
%for monoclinic lattice
%-------------------------------------------
aa=[lp(1);0;0];
bb=[lp(2)*cosd(lp(6));lp(2)*sind(lp(6));0];
cc=[lp(3)*cosd(lp(5));0;lp(3)*sind(lp(5))];

A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));
%-------------------------------------------

sf_list1=importdata(NAME_sf);
sf_list=[sf_list1,zeros(size(sf_list1,1),1)];
for l=1:size(sf_list,1)
    HKL=sf_list(l,1:3).';
    XYZ=A*HKL;
    sf_list(l,size(sf_list,2))=1/sqrt(XYZ.'*XYZ);
    
end
[temp,ind]=sort(sf_list(:,size(sf_list,2)),'descend');
sf_list=sf_list(ind,:);
[row1]=find(sf_list(:,size(sf_list,2))<=res(1),1);
[row2]=find(sf_list(:,size(sf_list,2))<=res(2),1);

if isempty(row2)
    row2=size(sf_list,1);
else
end

sf_list=sf_list(row1:row2,:);



sf_list_ext=zeros(8*size(sf_list,1),size(sf_list,2));


row_counter=1;
for l=1:size(sf_list,1)
    H=sf_list(l,1);
    K=sf_list(l,2);
    L=sf_list(l,3);
    if H==0
        if K==0
            if L==0
                sf_list_ext(row_counter,:)=sf_list(l,:);
                row_counter=row_counter+1;
            else
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[0,0,-L,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+2;
            end
        else
            if L==0
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[0,-K,0,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+2;
            else 
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[0,K,-L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+2,:)=[0,-K,L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+3,:)=[0,-K,-L,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+4;
            end
        end
    else
        if K==0
            if L==0
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[-H,0,0,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+2;
            else 
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[H,0,-L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+2,:)=[-H,0,L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+3,:)=[-H,0,-L,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+4;
            end
        else
            if L==0 
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[H,-K,0,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+2,:)=[-H,K,0,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+3,:)=[-H,-K,0,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+4;
            else
                sf_list_ext(row_counter,:)=sf_list(l,:);
                sf_list_ext(row_counter+1,:)=[H,K,-L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+2,:)=[H,-K,L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+3,:)=[-H,K,L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+4,:)=[H,-K,-L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+5,:)=[-H,K,-L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+6,:)=[-H,-K,L,sf_list(l,4:size(sf_list,2))];
                sf_list_ext(row_counter+7,:)=[-H,-K,-L,sf_list(l,4:size(sf_list,2))];
                row_counter=row_counter+8;
            end
        end
    end

end

sf_list_ext=sf_list_ext(1:row_counter-1,:);



end