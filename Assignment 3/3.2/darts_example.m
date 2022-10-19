% Dart Example: Calculating Pi
clc; clear all; close all;

r = 1;

num_darts = 1e4;
count_in = 0;

% % figure
% % set(gcf,"Color",[1,1,1])
% % 
% % filename = 'darts';
% % initVideo

tic
for ii = 1:num_darts
    % Randomly throw a dart
    new_dart_position = [2*r*rand-r, 2*r*rand-r];
    
    % how far is it from center?
    dist = norm(new_dart_position);
    
% %     hold on
    % Is it inside the circle?
    if(dist <= r)
        % Update the  count
        count_in = count_in + 1;
% %         dart_color = [1,0,0];
% %         plot(new_dart_position(1), new_dart_position(2), 'o','Color',dart_color)
% %     else
% %         dart_color = [0,0,1];
% %         plot(new_dart_position(1), new_dart_position(2), '+','Color',dart_color)
    end
    
% %     xlim([-1,1]);
% %     ylim([-1,1]);
% %     daspect([1,1,1])
% %     drawnow
% %     addVideoFrame
    
%     count_in = count_in + (norm([2*rand-1, 2*rand-1]) <= 1);
end

% A_circle / A_square = pi*r*r / 4*r*r = pi/4
% Approximation: A_circle / A_square = # darts in circle / # darts in square

% -> pi = (4*# darts in circle / # darts in square)

approx_pi = 4*count_in / num_darts
toc
% % endVideo
