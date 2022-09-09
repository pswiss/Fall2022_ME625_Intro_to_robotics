clc
clear all
close all

T = eye(4);


filename = 'cool video 1'
initVideo;

for xx = 0:0.1:5
    clearDisplay()
    T(1, 4) = T(1, 4)+0.1;
    drawRobotLink(T, 4, 0.5, 0.2, [1, 0, 0])
    configureWindow();
    addVideoFrame
end

saveFigureAsImage('hi');

endVideo

filename = 'cool video 2'
initVideo;

for xx = 0:0.1:5
    clearDisplay()
    T(1, 4) = T(1, 4)-0.1;
    drawRobotLink(T, 4, 0.5, 0.2, [1, 0, 0])
    configureWindow();
    addVideoFrame
end

saveFigureAsImage('hi2');

endVideo

    