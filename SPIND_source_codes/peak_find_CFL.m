%"peak_find_CFL.m" finds Bragg peaks of a pattern and convert it to a list
%file.

%----------------------
%NAME_file: the .mat file to be loaded that includes the pattern matrix.
%thld: intensity threshold above which the pixel is recognized as a Bragg
%spot.
%----------------------

function [peak_list] = peak_find_CFL(NAME_file,thld)


load(NAME_file);
[row,col]=find(Int_1C>thld);
Int_R=zeros(size(Int_1C));
peak_list=zeros(size(row,1),4);
peak_list(:,1:2)=[row,col];
peak_list(:,4)=ones(size(row,1),1);
for l=1:size(row)
    Int_R(row(l),col(l))=1;
    peak_list(l,3)=Int_1C(row(l),col(l));
end
figure;pcolor(Int_R);shading interp;colormap gray;colorbar;axis square;


end