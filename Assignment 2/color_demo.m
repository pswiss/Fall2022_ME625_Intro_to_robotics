% Quick script to demonstrate the color from image function
clc;
clear all;
close all;


image = imread('r.png');
figure
hold on
grid on
for ii = 1:5:180
    for jj = 1:5:180
        color = colorFromXYOnImage(image,ii,jj);
        plot(ii,jj,'o','Color',color, 'MarkerFaceColor',color)
        drawnow
    end
end