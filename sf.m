clc
close all
clear all
% Read image from File
% files = dir('C:\Users\kavya\Desktop\New Folder');
% dirFlags = [files.isdir];
% subFolders = files(dirFlags);
% for k =1 : length(subFolders)
%  my_folder =fullfile('C:\Users\kavya\Desktop\New Folder',subFolders(k).name);
%  filenames=dir(fullfile(my_folder,'*.jpg'));
%  for n = 1:numel(filenames)
%   fullname=fullfile(my_folder,filenames(n).name);
%     %---------------------------------------------------------------------------------------
img = imread('C:\Users\kavya\Desktop\New Folder\5.jpg');
 
% resize the image
img = imresize (img, [128 128]);
figure (3), imshow(img);
% Template Type
T1 = [0,1,1]';
T2 = T1';
T3 = [ 1,1,0]';
T4 = T3';
[row col plane] = size(img);
imgBin = double(im2bw(img));
ouImg = imgBin;
S = [1 3 5 7];
checKVal = 2;
template = 1;
outBinary =zeros (row, col);
con = 5;
while (con < 15)
    for i = 2: row-1
        for j = 2: col-1
            window = imgBin (i-1: i+1, j-1: j+1);
            if (template == 1)
                andOp1 = isequal (window (:,2), T1);
                matchTemplate = andOp1;
            end
            if (template == 2)
                andOp1 = isequal (window (2, :), T2);
                matchTemplate = andOp1;
            end
            if (template == 3)
                andOp1 = isequal(window(:,2), T3);
                matchTemplate = andOp1;
            end
            if (template == 4)
                andOp1 = isequal(window(2,:),T4);
                matchTemplate = andOp1;
            end
            %         Connectivity number
            [Cn EndPoint] = connectivityFun(window);
            if imgBin (i, j) ==1
                if ((matchTemplate) == 1)
                    if Cn == 1
                        if (EndPoint ~= 0)
                            outBinary (i, j) = 1;
                        end
                    end
                end
            end
        end
    end
    checKVal = sum(sum(outBinary));
    if (checKVal==0)
        con = con+1;
    end
    binVal = find(outBinary==1);
    imgBin(binVal) = 0;
    figure (2), imshow (outBinary, []);
    outBinary =zeros (row, col);
    template = template+1;
    %     Iteration
    if template == 5
        figure (1), imshow (imgBin, []); title ('Output Thinning Image');
        outBinary =zeros (row, col);
        template = 1;
    end
end
close all;
% figure (3), imshow(img); title ('Input Thinning Image');
figure (1), imshow (imgBin, []); title ('Output Thinning Image');
%------------------------------------------------------------------
B =  bwmorph(imgBin,'branchpoints'); % skeleton junction points
[i,j] = find(bwmorph(imgBin,'endpoints')); % skeleton end points
BT = Boundary_junct(imgBin,'testing'); % boundary junctions
BL=edge(imgBin,'canny',.305); % boundary length
[u,v] = find(BL == 1);
[a,b] = find(imgBin == 1);% skeleton length

Feat = [sum(sum(B)) length(i) sum(BT) length(u) length(a)];
%  end
% end
