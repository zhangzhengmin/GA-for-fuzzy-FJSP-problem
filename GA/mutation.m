%
% Project Title: GA in MATLAB
%
% Developer: ZZM in HUST
%
% Contact Info:hust_zzm@hust.edu.cn
%

function Offspring = mutation(Offspring,nPop,len,job_info,job_position,Mutation_rate)

for t=1:nPop
    Off=Offspring(t,:);
    if rand(1)<Mutation_rate
        pos1=randperm(len,ceil(rand(1)*len/2));
        pos2=randperm(len,ceil(rand(1)*len/4));
        %Cross
        for c=pos1
            if any(c==job_position)
                a=1;
                b=find(c+1==Off(1,1:len));
            elseif any(c+1==job_position)
                a=find(c==Off(1,1:len));
                b=len;
            else
                a=find(c-1==Off(1,1:len));
                b=find(c+1==Off(1,1:len));
            end
            old_p= find(c==Off(1,1:len));
            old_m=Off(1,old_p+len);
            Off(1,old_p)=0;
            Off(1,old_p+len)=0;
            if a==b
                p=randi([a,b],1);
            else
                p=randi([a,b-1],1);
            end
            if p==len
                Off=[Off(1,1:p),c,Off(1,len+1:len+p),old_m];
            else
                Off=[Off(1,1:p),c,Off(1,p+1:len),Off(1,len+1:len+p),old_m,Off(1,len+p+1:2*len)];
            end
            Off(find(0==Off(1,:)))=[];
        end
        %Mutation
        for m=pos2
            Off(m+len)=job_info{m,3}(randperm(length(job_info{m,3}),1));
        end
    end
    Offspring(t,:)=Off;
end