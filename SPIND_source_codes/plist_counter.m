% plist_counter.m counts the number of peak list txt files in a run folder.

function [end_id]=plist_counter(folder)
oldfolder=cd(folder);
list=dir('I3C*.txt');
end_id=size(list,1);



cd(oldfolder);
end
