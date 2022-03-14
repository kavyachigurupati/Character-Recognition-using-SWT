function [Feat1] = Feature1(Img)

B =  bwmorph(Img,'branchpoints'); % skeleton junction points
[i,j] = find(bwmorph(Img,'endpoints')); % skeleton end points
BT = Boundary_junct(Img,'testing'); % boundary junctions
BL=edge(Img,'canny',.305); % boundary length
[u,v] = find(BL == 1);
[a,b] = find(Img == 1);% skeleton length

Feat1 = [sum(sum(B)) length(i) sum(BT) length(u) length(a)];
end