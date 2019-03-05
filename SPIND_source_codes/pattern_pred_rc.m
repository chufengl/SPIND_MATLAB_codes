%"pattern_pred_rc.m" 

function [Int_p]= pattern_pred_rc(lp,Xsize,Msize,Mosaicity,E_ph,I0,R_beam,res,pixelsize,L,SCA,Q,C)
lamda=12.4/E_ph;
k0=1/lamda;
N_pix=2*round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1;

A=zeros(3);
A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
A(2,2)=1/lp(2)*sind(lp(6));
A(3,3)=1/lp(3);


Int_p=zeros(N_pix,N_pix);% calculate the intensities of all pixels.

for k=1:N_pix
    x0=(k-(N_pix+1)/2)*pixelsize*1e-6;
    for l=1:N_pix
        y0=(l-(N_pix+1)/2)*pixelsize*1e-6;
        x_p=k0*x0/sqrt(x0^2+y0^2+L^2);
        y_p=k0*y0/sqrt(x0^2+y0^2+L^2);
        z_p=k0*(1-L/sqrt(x0^2+y0^2+L^2));
        
        
%             Q=Q_X_p;
            XYZ=Q*[x_p,y_p,z_p].';
            
            [HKL,HKL_in,sf]=general_sf(A,XYZ,res);
            DeltaHKL=HKL-HKL_in;
            sigma_M=Mosaicity*pi/180;
            sigma_X=(1/(10*Msize))/sqrt(HKL_in(1)^2/lp(1)^2+HKL_in(2)^2/lp(2)^2+HKL_in(3)^2/lp(3)^2)*C;
            sigma_eff=sqrt(sigma_X^2+sigma_M^2);
%             sigma_eff=sigma_X+sigma_M;
            r_q=sigma_eff*sqrt(HKL_in(1)^2/lp(1)^2+HKL_in(2)^2/lp(2)^2+HKL_in(3)^2/lp(3)^2);
%             Int_p(l,k)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^2*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*r_q^2))*(10*Xsize/lp(1))^3*(1/r_q)^2; %the last factor is the normalization factor considering the resolution dependence.
            if sqrt(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)<=(1.5*r_q)
                Int_p(l,k)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^2*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*r_q^2))*(10*Xsize/lp(1))^3;%*(1/r_q)^2;%Gaussian model without normalization prefactor.
            else
                
            end
            
            
            
            
        
    end
end