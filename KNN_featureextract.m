clc
clear all
close all
warning off
dbstop if error
F = dir('.\Data2\*.*');
inc = 1;
m=1
n=1
p=1;
q=10;
m1=1;
sum=0;
for i = 3:length(F)
    %l=1
     F1 = dir(['.\Data2\' F(i).name '\*.jpg']);
     for j = 1:length(F1)
          I1 = imread(['.\Data2\' F(i).name '\' F1(j).name]);
           I1=double(rgb2gray(I1));
        Skt = bwmorph(I1,'skel',Inf);
          Feat1(inc,:) = Feature1(Skt);
         Tar(inc,:) = i-2;
         inc = inc+1;
     end
 end
%%%%%%%  
load Feat1.mat
for i=1:10:inc-1
    for j=1:6
        for k=p:q
            sum=sum+Feat1(k,j)   
         end
        avg=sum/10
        feature(m,j)=avg
        sum=0
     end
         p=p+10
         q=q+10
         m=m+1
end

%%%%%%%%%%%
img=imread('A.jpg');
out=[169 67 1993 2746 560 496];
min=999;
for i=1:6
   
    %res(i,1)=sqrt(power(feature(i,j)-out(1,1),2)+power(feature(i,j+1)-out(1,2),2)+power(feature(i,j+2)-out(1,3),2)+power(feature(i,j+3)-out(1,4),2)+power(feature(i,j+4)-out(1,5),2)+power(feature(i,j+5)-out(1,6),2)+power(feature(i,j+6)-out(1,7),2)+power(feature(i,j+7)-out(1,8),2)+power(feature(i,j+8)-out(1,9),2)+power(feature(i,j+9)-out(1,10),2)+power(feature(i,j+10)-out(1,11),2)+power(feature(i,j+11)-out(1,12),2)+power(feature(i,j+12)-out(1,13),2)+power(feature(i,j+13)-out(1,14),2)+power(feature(i,j+14)-out(1,15),2)+power(feature(i,j+15)-out(1,16),2))
    dist=abs(feature(i,:)-out);
    sumDist=0;
    for j=1:6
     sumDist=sumDist+dist(1,j);
    end
    if min>sumDist
        min=sumDist;
        mI=i;
    end
end
disp('the recognized index of the character')
disp(mI);
disp('the recognized character')
switch mI
    case 1
        disp('A')
    case 2
        disp('B')
    case 3
        disp('C')
    case 4
        disp('D')
    	
end



