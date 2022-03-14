% clc;
% clear;
x=imread('color.jpg');
thr = graythresh(x);
BW=im2bw(x,thr);
x=rgb2gray(x);
x=double(x);
[a, b]=size(x);
imshow(x,[]);
figure;
imshow(BW,[]);
%------dilation---------
dil=zeros(a,b);
se=ones(3,3);
dil=imdilate(BW,se);
title('original');
figure;
imshow(dil,[]);
%------erosion----------
ero=zeros(a,b);
ero=imerode(BW,se);
figure;
imshow(ero,[]);
%------open------------
open=zeros(a,b);
open=imdilate(ero,se);
figure;
imshow(open,[]);
%------closing-----------
close=zeros(a,b);
close=imerode(dil,se);
figure;
imshow(close,[]);
%-------------------
out=zeros(a,b);
for i=1:a
    for j=1:b
        out(i,j)=(open(i,j)+close(i,j))/2;
    end;
end;
figure;
title('blurred image in step 1');
imshow(out,[]);
%-----------------
dil2=zeros(a,b);
dil2=imdilate(out,se);
figure;
imshow(dil2,[]);
%---------------
ero2=zeros(a,b);
ero2=imerode(out,se);
figure;
imshow(ero2,[]);
%----------------
morp=zeros(a,b);
for i=1:a
    for j=1:b
        morp(i,j)=dil2(i,j)-ero2(i,j);
    end;
end;
figure;
imshow(morp,[]);
%----step2---------
g1=[-1 0 1];
g2=[-1;0;1];
w1=conv2(morp,g1);
w2=conv2(morp,g2);
figure;
imshow(w1,[]);
figure;
imshow(w2,[]);
s=zeros(a,b);
%----------assign max values to s----
for i=1:a
    for j=1:b
        if w1(i,j)>=w2(i,j)
            s(i,j)=w1(i,j);
        else
            s(i,j)=w2(i,j);
        end;
    end;
end;
%-------------------
final=zeros(a,b);
for i=1:a
    for j=1:b
        final(i,j)=s(i,j)*morp(i,j);
    end;
end;
sum=0;
for i=1:a
    for j=1:b
        sum=sum+final(i,j);
    end
end
sum1=0;
for i=1:a
    for j=1:b
        sum1=sum1+s(i,j);
    end
end
threshold=-(sum/sum1);
%------step 3-----------
%-------find image e image----
e=zeros(a,b);
for i=1:a
    for j=1:b
        if threshold<morp(i,j)
            e(i,j)=1;
        end
    end
end
figure;
imshow(e,[]);

%-----------dilation on e image-----
ec1=zeros(a,b);
ec1=imdilate(e,se);
figure;
imshow(ec1,[]);
%-----erosion on ec1-----
ec=zeros(a,b);
ec=imerode(ec1,se);
figure;
imshow(ec,[]);
% %----------------------
% [swtLabel numCC] = swtlabel(ec);
% %----------eliminate non text region-------------
