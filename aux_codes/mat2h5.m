%"mat2h5.m" converts matlab data files to h5 files.
function []= mat2h5(PATH,FNAME_com,startfileID,endfileID)

File_v=startfileID:endfileID;
for k=File_v 
    FNAME_mat=[FNAME_com,num2str(k),'.mat'];
    FNAME_h5=[FNAME_com,num2str(k),'.h5'];
    matfile=fullfile(PATH,FNAME_mat);
    h5file=fullfile(PATH,FNAME_h5);
    load(matfile);
    h5create(h5file,'/photon_energy_eV',[1 1]);
    E_ph=9610;
    h5write(h5file,'/photon_energy_eV',E_ph);
    h5create(h5file,'/data',size(Int_1C),'Datatype','int16');
    h5write(h5file,'/data',int16(Int_1C));
end
end

