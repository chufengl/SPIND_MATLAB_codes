%?detc2ES_mapping.m? maps the Bragg spots on the detector back to the 3-D reciprocal
%ES.

function [peak_c_list] = detc2ES_mapping(peak_list1,w_thld,E_ph,pixelsize,L,SCA)

lamda=12.4/E_ph;
k0=1/lamda;
N_pix=2*round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1;


[temp,ind]=sort(peak_list1(:,3),'descend');

peak_list1=peak_list1(ind,:);
peak_c_list=zeros(size(peak_list1,1),9);
row_counter=2;

peak_c_list(1,1:3)=peak_list1(1,1:3);
for l=2:size(peak_list1,1)
    jud_s=0;
    for k=1:l
        y_p=peak_c_list(k,1);
        x_p=peak_c_list(k,2);
        jud=(peak_list1(l,1)<=(y_p+w_thld))&(peak_list1(l,1)>=(y_p-w_thld))&...
            (peak_list1(l,2)<=(x_p+w_thld))&(peak_list1(l,2)>=(x_p-w_thld));
        jud_s=jud_s+jud;
    end
    
    if jud_s==0
        
        peak_c_list(row_counter,1:3)=peak_list1(l,1:3);
        row_counter=row_counter+1;
        
        
    else
        
    end
end
peak_c_list=peak_c_list(1:(row_counter-1),:);

peak_c_list(:,4:5)=(peak_c_list(:,[2,1])-(round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1)*ones(size(peak_c_list(:,1:2))))*pixelsize*1e-6;

for l=1:size(peak_c_list,1)
    c_v=[peak_c_list(l,4:5),-L].';
    k_v=k0*c_v/sqrt(c_v.'*c_v);
    peak_c_list(l,6:8)=[0,0,k0]+k_v.';
    peak_c_list(l,9)=1/sqrt(peak_c_list(l,6:8)*peak_c_list(l,6:8).');
end
 


end