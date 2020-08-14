%
% Project Title: GA in MATLAB
% 
% Developer: ZZM in HUST
% 
% Contact Info:hust_zzm@hust.edu.cn
%

function z = processingtime(x, job_position,machine_number,job_time)
tc=zeros(machine_number,3);
ts=zeros(length(job_position)-1,3);

for j=1:length(x)/2
   machine_loc=x(length(x)/2+j);
   job_loc=length(find(job_position<=x(j)));
   if any(x(j)==job_position)
       tc(machine_loc,:)=tc(machine_loc,:)+job_time(x(j),:);
       ts(job_loc,:)=tc(machine_loc,:);
   else
       tc(machine_loc,1)=max(ts(job_loc,1),tc(machine_loc,1))+job_time(x(j),1);
       tc(machine_loc,2)=max(ts(job_loc,2),tc(machine_loc,2))+job_time(x(j),2);
       tc(machine_loc,3)=max(ts(job_loc,3),tc(machine_loc,3))+job_time(x(j),3);
       ts(job_loc,:)=tc(machine_loc,:);
   end
end
[~,index]=max(tc(:,3));
z=tc(index,:);
end