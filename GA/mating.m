%
% Project Title: GA in MATLAB
%
% Developer: ZZM in HUST
%
% Contact Info:hust_zzm@hust.edu.cn
%

function Mating_pool=mating(nPop,len,population,result)
Mating_pool=zeros(nPop,len*2);
for i=1:nPop/2
    if result(2*i-1,1)<=result(2*i,1)
        Mating_pool(i,:)=population(2*i-1,:);
    else 
        Mating_pool(i,:)=population(2*i-1,:);
    end
end
 n=randperm(nPop,nPop);
 for i=1:nPop/2
    if result(n(2*i-1))<=result(n(2*i))
        Mating_pool(nPop/2+i,:)=population(n(2*i-1),:);
    else
        Mating_pool(nPop/2+i,:)=population(n(2*i),:);
    end
 end
end