%
% Project Title: GA in MATLAB
%
% Developer: ZZM in HUST
%
% Contact Info:hust_zzm@hust.edu.cn
%

function Offspring=gen(nPop,len,job,Mating_pool,Cross_rate,Mutation_rate)
Offspring=zeros(nPop,len*2);

for i=1:2:nPop
    a=Mating_pool(i,:);
    b=Mating_pool(i+1,:);
    if rand(1)<Cross_rate
        r1=sort(randperm(length(job),ceil(rand(1)*length(job))));
        r2=setxor(r1,[1:1:length(job)]);
        rand1=[];
        rand2=[];
        for j=r1
            rand1=[rand1,job{1,j}];
        end
        for j=r2
            rand2=[rand2,job{1,j}];
        end
        
        for j=rand1
            rand1_loc=find(j==a(1:len));
            Offspring(i,rand1_loc)=j;
            Offspring(i,rand1_loc+len)=a(rand1_loc+len);
        end
        
        [pro,ia]=setdiff(b(1:len),rand1,'stable');
        loc=find (Offspring(i,1:len)==0);
        
        for j=1:length(loc)
            Offspring(i,loc(j))=pro(j);
            Offspring(i,loc(j)+len)=b(ia(j)+len);
        end
        
        for j=rand2
            rand2_loc=find(j==b(1:len));
            Offspring(i+1,rand2_loc)=j;
            Offspring(i+1,rand2_loc+len)=b(rand2_loc+len);
        end
        
        [pro,ia]=setdiff(a(1:len),rand2,'stable');
        loc=find (Offspring(i+1,1:len)==0);
        
        for j=1:length(loc)
            Offspring(i+1,loc(j))=pro(j);
            Offspring(i+1,loc(j)+len)=a(ia(j)+len);
        end
    else
        Offspring(i,:)=a;
        Offspring(i+1,:)=b;
    end
end
