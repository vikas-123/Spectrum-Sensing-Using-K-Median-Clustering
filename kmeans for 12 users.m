%A = fileread('dataset.txt');
%C = strsplit(A);
%D= sort(C);
A= dlmread('12X100finaldata.txt');
After_sort = sort(A);
l = length(After_sort);
first_center_index = l/4;
second_center_index = 3*l/4;
value_of_first_center = After_sort(first_center_index);
value_of_second_center = After_sort(second_center_index);
plot(A,0,'x');
title('Distribution of Max Energy for 12 SUs');
hold on
%plot(A(75),0,'-rp');


