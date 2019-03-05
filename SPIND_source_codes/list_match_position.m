%"list_match_position.m" estimates the match of two lists based on
%positions of Bragg peaks.

% peak_list convention:

%peak_list1-- real pattern list(col1:y coordinate;col2:x coordinate;col3:itensity)
%peak_list2-- predicted pattern list(col1~3:HKL indices;col4:y coordinate;col5: x coordinate;col6:peak width;col7:intensity)


function [match_list,p1,p2] = list_match_position(peak_list1,peak_list2,w_thld)

match_list=zeros(size(peak_list1,1),7);
order_counter=0;
match_counter=0;
for l=1:size(peak_list2,1)
    y_p=peak_list2(l,4);
    x_p=peak_list2(l,5);
    row=find((peak_list1(:,1)>=y_p-w_thld)&(peak_list1(:,1)<=y_p+w_thld)&...
        (peak_list1(:,2)>=x_p-w_thld)&(peak_list1(:,2)<=x_p+w_thld));
    if isempty(row) 
        
    else
        
        match_list((match_counter+1):(match_counter+size(row)),1:3)=ones(size(row))*...
            peak_list2(l,1:3);
        match_list((match_counter+1):(match_counter+size(row)),4:6)=ones(size(row))*peak_list2(l,[4,5,7]);
        match_list((match_counter+1):(match_counter+size(row)),7)=peak_list1(row,3);
        match_counter=match_counter+size(row,1);
        order_counter=order_counter+1;
    end
    
end
p1=order_counter/size(peak_list2,1);
p2=match_counter/size(peak_list1,1);

match_list=match_list(1:match_counter,:);
% disp(['matching percentage is',num2str(p1),'and',num2str(p2)]);


end