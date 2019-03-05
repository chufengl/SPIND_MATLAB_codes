% peak_list_conv.m converts tgrant's list to "my" list format.

function [peak_c_list] = peak_list_conv(NAME_list,coffset,pixelsize)



t_list=importdata(NAME_list);
%[~,ind]=sort(t_list(:,3),'descend'); %sort peaks according to intensity.
%t_list=t_list(ind,:);


size_list=size(t_list,1);
peak_c_list=zeros(size_list,9);
L=t_list(1,6)/1e3+coffset;

E_ph=t_list(1,5);

lamda=12.4/(E_ph/1e3);
k0=1/lamda;

peak_c_list(:,1)=-t_list(:,2);
peak_c_list(:,2)=t_list(:,1);
peak_c_list(:,3)=t_list(:,3);

peak_c_list(:,4:5)=(peak_c_list(:,[2,1]))*pixelsize*1e-6;

for l=1:size(peak_c_list,1)
    c_v=[peak_c_list(l,4:5),-L].';
    k_v=k0*c_v/sqrt(c_v.'*c_v);
    peak_c_list(l,6:8)=[0,0,k0]+k_v.';
    peak_c_list(l,9)=1/sqrt(peak_c_list(l,6:8)*peak_c_list(l,6:8).');
end
%[~,ind]=sort(peak_c_list(:,9),'descend'); %sort peaks according to resolution.
[~,ind]=sort(peak_c_list(:,3),'descend'); %sort peaks according to intensity.
peak_c_list=peak_c_list(ind,:);

end
