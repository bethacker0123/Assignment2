clc;clear;
xCords1 = zeros(1,258);
yCords1 = zeros(1,258);
xCords2 = zeros(1,258);
yCords2 = zeros(1,258);
for index = 1:258
    if index <10
        jpgFileName = sprintf('img00%d.jpg',index);
        fullFileName = fullfile('balls',jpgFileName);
    elseif index < 100
        jpgFileName = sprintf('img0%d.jpg',index);
        fullFileName = fullfile('balls',jpgFileName);
    else
        jpgFileName = sprintf('img%d.jpg',index);
        fullFileName = fullfile('balls',jpgFileName);
    end
    if exist (fullFileName,'file')
        if index > 1
             prevImage = currentImage;
             currentImage = imread(fullFileName);
             
            
             diff1= abs(createMask(prevImage)-createMask(currentImage));
             [labels1,number1] = bwlabel(diff1,8);
             diff2= abs(createMask2(prevImage)-createMask2(currentImage));
             [labels2,number2] = bwlabel(diff2,8);
               if number1 > 0   
                iStats = regionprops(labels1, 'basic','Centroid');
             
                [maxVal,maxIndex] = max([iStats.Area]);
                xCords1(1,index) = iStats(maxIndex).Centroid(1);
                yCords1(1,index) = iStats(maxIndex).Centroid(2);
               end 
               if number2 > 0   
                iStats = regionprops(labels2, 'basic','Centroid');
             
                [maxVal,maxIndex] = max([iStats.Area]);
                xCords2(1,index) = iStats(maxIndex).Centroid(1);
                yCords2(1,index) = iStats(maxIndex).Centroid(2);
               end 
                
        else
            currentImage = imread(fullFileName);
        end
    else
        warningMessage = sprintf('Warning: image file does not exist:\n%s',fullFileName);
        uiwait(warndlg(warningMessage));
    end
end
imshow(currentImage);
xCords1 = xCords1(xCords1~=0);
yCords1 = yCords1(yCords1~=0);
xCords2 = xCords2(xCords2~=0);
yCords2 = yCords2(yCords2~=0);
    hold on;
   scatter(xCords1(1,:),yCords1(1,:));
   scatter(xCords2(1,:),yCords2(1,:));
