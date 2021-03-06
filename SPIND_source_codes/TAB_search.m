%%"TAB_search.m" searches in TAB for the match to designated lra parameter set.

function [ind_match,MATCH] =TAB_search(TAB,lra,lra_error)

ind_match1=find((abs(TAB(:,7)-lra(1))<lra_error(1)*TAB(:,7))&...
    (abs(TAB(:,8)-lra(2))<lra_error(2)*TAB(:,8))&...
    (abs(TAB(:,9)-lra(3))<lra_error(3)*TAB(:,9))&...
    (abs(TAB(:,10)-lra(4))<abs(lra_error(4)*TAB(:,10))));


MATCH1=zeros(size(ind_match1,1),14);
MATCH1(:,1:10)=TAB(ind_match1,:);

MATCH1(:,11:14)=[abs(TAB(ind_match1,7)-lra(1))./TAB(ind_match1,7),...
    abs(TAB(ind_match1,8)-lra(2))./TAB(ind_match1,8),...
    abs(TAB(ind_match1,9)-lra(3))./TAB(ind_match1,9),...
    abs(TAB(ind_match1,10)-lra(4))./TAB(ind_match1,10)];

ind_match2=find((abs(TAB(:,7)-lra(2))<lra_error(2)*TAB(:,7))&...
    (abs(TAB(:,8)-lra(1))<lra_error(1)*TAB(:,8))&...
    (abs(TAB(:,9)-(1/lra(3)))<lra_error(3)*TAB(:,9))&...
    (abs(TAB(:,10)-lra(4))<abs(lra_error(4)*TAB(:,10))));

MATCH2=zeros(size(ind_match2,1),14);
MATCH2(:,1:3)=TAB(ind_match2,4:6);
MATCH2(:,4:6)=TAB(ind_match2,1:3);
MATCH2(:,7)=TAB(ind_match2,8);
MATCH2(:,8)=TAB(ind_match2,7);
MATCH2(:,9)=1./TAB(ind_match2,9);
MATCH2(:,10)=TAB(ind_match2,10);
MATCH2(:,11:14)=[
    abs(TAB(ind_match2,8)-lra(1))./TAB(ind_match2,8),...
    abs(TAB(ind_match2,7)-lra(2))./TAB(ind_match2,7),...
    abs(TAB(ind_match2,9)-(1/lra(3)))./TAB(ind_match2,9),...
    abs(TAB(ind_match2,10)-lra(4))./TAB(ind_match2,10)];

ind_match=[ind_match1;ind_match2];
MATCH=[MATCH1;MATCH2];
end