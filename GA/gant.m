function [] = gant(best,len,machine_number,best_result,job_position,job_time)


figure(3)
axis([0,best_result(1,3)+1,0,machine_number+0.5]);%x-axis range+y-axis range
set(gca,'xtick',0:4:best_result(1,3)+1) ;%x-axis growth
set(gca,'ytick',0:1:machine_number+0.5) ;%y-axis growth
xlim=get(gca,'Xlim'); % 获取当前图形的横轴的范围
hold on
for i=1:machine_number
    plot(xlim,[i,i],'k-'); % 绘制y=1的直线
end
xlabel('加工时间'),ylabel('机器号');%name
title('最佳调度甘特图');%title
n_task_nb = len;%total tasks

%start time of each tasks
tc=zeros(machine_number,3);
ts=zeros(length(job_position)-1,3);
n_start_time=zeros(len,3);
n_job_id=zeros(len,1);

for j=1:len
    machine_loc=best(len+j);
    job_loc=length(find(job_position<=best(j)));
    n_job_id(j,1)=job_loc;
    
    if any(best(j)==job_position)
        tc(machine_loc,:)=tc(machine_loc,:)+job_time(best(j),:);
        ts(job_loc,:)=tc(machine_loc,:);
        n_start_time(j,:)=tc(machine_loc,:)-job_time(best(j),:);
    else
        tc(machine_loc,1)=max(ts(job_loc,1),tc(machine_loc,1))+job_time(best(j),1);
        tc(machine_loc,2)=max(ts(job_loc,2),tc(machine_loc,2))+job_time(best(j),2);
        tc(machine_loc,3)=max(ts(job_loc,3),tc(machine_loc,3))+job_time(best(j),3);
        ts(job_loc,:)=tc(machine_loc,:);
        n_start_time(j,:)=tc(machine_loc,:)-job_time(best(j),:);
    end
end

%end time of every task
n_end_time =n_start_time+job_time(best(1:len),:);
%y
n_bay_start=best(1,len+1:2*len);
%temp data space for every rectangle
rec=[0,0,0,0];
%color
color=['r','g','b','c','m','y','r','g','b','c','m','y','r','g','b','c','m','y'];

for i =1:n_task_nb
    %find the process number of each job
    job_loc=length(find(job_position<=best(i)));
    %start time
    x1= n_start_time(i,1);
    x2 = n_start_time(i,2);
    x3 = n_start_time(i,3);
    y1=n_bay_start(1,i);
    y2=y1-0.3;
    triangle_x=[x1,x2,x3,x1];
    triangle_y=[y1,y2,y1,y1];
    fill(triangle_x,triangle_y,color(n_job_id(i)));
        
    txt=sprintf('O(%d,%d)',job_loc,best(i)-job_position(job_loc)+1);
    text(n_start_time(i,2),(n_bay_start(i)-0.4),txt,'horiz','center','FontWeight','Bold','FontSize',4);%start time of every task
    txt=sprintf('(%d,%d,%d)',n_start_time(i,:));
    text(n_start_time(i,2),(n_bay_start(i)-0.1),txt,'horiz','center','FontWeight','Bold','FontSize',4);%start time of every task
    
    %end time
    x1= n_end_time(i,1);
    x2 = n_end_time(i,2);
    x3 = n_end_time(i,3);
    y1=n_bay_start(1,i);
    y2=y1+0.3;
    triangle_x=[x1,x2,x3,x1];
    triangle_y=[y1,y2,y1,y1];
    fill(triangle_x,triangle_y,color(n_job_id(i)));

        
    txt=sprintf('O(%d,%d)',job_loc,best(i)-job_position(job_loc)+1);
    text(n_end_time(i,2),(n_bay_start(i)+0.4),txt,'horiz','center','FontWeight','Bold','FontSize',4);%end time of every task
    txt=sprintf('(%d,%d,%d)',n_end_time(i,:));
    text(n_end_time(i,2),(n_bay_start(i)+0.1),txt,'horiz','center','FontWeight','Bold','FontSize',4);%end time of every task

end
alpha(0.4);
end