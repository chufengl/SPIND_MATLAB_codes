%"assemble_goem.m" assembles the raw .h5 data according to geometry.

function [Int_asm,E_ph,L,SCA] = assemble_geom(NAME_h5,NAME_geom,pixelsize)



Int_raw=h5read(NAME_h5,'/data/rawdata0');
coffset=582.00e-3;
L=h5read(NAME_h5,'/LCLS/detector0-EncoderValue')*1e-3+coffset;
E_ph=h5read(NAME_h5,'/LCLS/photon_energy_eV')/1000;
pixelmap_x=h5read(NAME_geom,'//x');
pixelmap_y=h5read(NAME_geom,'//y');
% pixelmap_z=h5read(NAME_geom,'//z');

N_pixel=2*ceil(max([max(max(abs(pixelmap_x))),max(max(abs(pixelmap_y)))])/(pixelsize*1e-6))+1;
SCA=atand((N_pixel-1)/2*pixelsize*1e-6/L);

Int_asm=zeros(N_pixel);

pixelmap_x_p=round(pixelmap_x/(pixelsize*1e-6))+(N_pixel+1)/2;

pixelmap_y_p=round(pixelmap_y/(pixelsize*1e-6))+(N_pixel+1)/2;

for l=1:size(Int_raw,1)
    for k=1:size(Int_raw,2)
        row=pixelmap_y_p(l,k);
        col=pixelmap_x_p(l,k);
        Int_asm(row,col)=Int_raw(l,k);
    end
end
figure;pcolor(Int_asm);shading interp;colormap gray;colorbar;axis square;caxis([0 1]);
end