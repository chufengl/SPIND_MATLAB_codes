%"dif_sim_CFL.m" is a new way of calculating the diffraction pattern. It is
%based on lattice point tracking instead of detector pixel tracking.


%------------------------------------
%lp: lattice parameters
% NAME_sf: name of the structrure factor list file
% res: resolution limit
% E_ph: X-ray photon energy
% I0: number of photons per pulse
% R_beam: beam radius
% pixelsize: detector pixelsize in um.
% L: camera length
% Q: rotation matrix
% C: mosaicity coefficient
% thld:
%------------------------------------
function [Int_p,peak_list] = dif_sim_CFL(lp,E_ph,Xsize,Msize,mos,I0,R_beam,pixelsize,L,SCA,Q,C)
 global sf_list
lamda=12.4/E_ph;
k0=1/lamda;
N_pix=2*round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1;


Int_p=zeros(N_pix,N_pix);


% sf_list_incom=importdata(NAME_sf);
% [sf_list]=sf_ext(NAME_sf,res,lp);

peak_list=zeros(size(sf_list,1),7);

A=zeros(3);
A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
A(2,2)=1/lp(2)*sind(lp(6));
A(3,3)=1/lp(3);

row_counter=1;

for l=1:size(sf_list,1)
    HKL=sf_list(l,1:3).';
    XYZ0=A*HKL;
%     if XYZ0.'*XYZ0<=(1/res)^2
        XYZ=Q\XYZ0;
        XYZ_v=XYZ-[0;0;k0];
        sg=k0-sqrt(XYZ_v.'*XYZ_v);%excitation error convention: +:inside ES;-:outside ES
        sigma_M=mos*pi/180;
        sigma_X=(1/(10*Msize))/sqrt(XYZ0.'*XYZ0)*C;
        r=1*sqrt(sigma_X^2+sigma_M^2)*sqrt(XYZ0.'*XYZ0);
        if abs(sg)<(1*r)
            
            dtheta=acosd((k0^2+(k0-sg)^2-r^2)/(2*k0*(k0-sg)));
            sca_2theta=acosd(dot([0;0;-k0],XYZ_v)/(k0*(k0-sg)));
            center_v=(XYZ_v/(k0-sg))*L/cosd(sca_2theta);
            
%             (XYZ_v/(k0-sg))
%             center_v.'
%             
            center_x=center_v(1);
            center_y=center_v(2);
            center_x_p=round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1+round(center_x/(pixelsize*1e-6));
            center_y_p=round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1+round(center_y/(pixelsize*1e-6));
%            center_x_p,center_y_p
            radius_peak=0.1*(L*cosd(sca_2theta)^(-2)+L/cosd(sca_2theta))*(dtheta/180*pi)/2;
            w=round(radius_peak/(pixelsize*1e-6));
            
            sf=sf_list(l,4);
            for m=-w:1:w
                for n=-w:1:w
                    Int_p(center_y_p+m,center_x_p+n)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^1*(pixelsize*1e-6/L)^2*exp(-(sg^2)/(20*r^2))*exp(-(m^2+n^2)/((w+0.01)^2))*(10*Xsize/lp(1))^3;%*(1/r_q)^2
%                     dif_list(counter,:)=[center_y_p+m,center_x_p+n,Int_p(center_y_p+m,center_x_p+n),1];
                end
                
            end
            peak_list(row_counter,1:3)=HKL.';
            peak_list(row_counter,4:7)=[center_y_p,center_x_p,w,Int_p(center_y_p,center_x_p)];
            row_counter=row_counter+1;
%             disp([num2str(HKL.'),'sg=',num2str(sg),'r=',num2str(r),'w=',num2str(w)]);
           
        else
        end
        
%     else
%         
%     end
end
peak_list=peak_list(1:row_counter-1,:);

    figure;pcolor(Int_p);shading interp;axis square;colormap gray;colorbar;caxis([0 1]);





end