%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ME 625 Assignment 2
% Name: Your Name
% Run file for part # [put what section this run is for]

% A few examples 
% Flocking / Boids:     https://www.youtube.com/watch?v=QbUPfMXXQIY
% Hop Localization:     https://www.youtube.com/watch?v=K2DWJeIYEho
% Brazil Nut effect:    https://drive.google.com/file/d/1C9mxYO1rKvDVYFys4CV_mAD6rBNxE3DK/view?usp=sharing
% Distributed behaviors:    https://www.youtube.com/watch?v=GnyDAuqorGo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all;
dt = 0.01;
robot_radius = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First, Initialize the system
% Robot initialization: robot( [position x, position y], angle, role)
robot_array = [robot([0,0],0,1), robot([5,0], 0, 2), ...
                robot([2.5,3],0,3), robot([-5,-5],0,4)];

light_location = [0,0];

script_drawWorld

exit_condition = false;

paths = [];

simstep = 0;

while(~exit_condition)
    for(rr = 1:length(robot_array))
        % Load in the light location
        vec_light = light_location-robot_array(rr).position;
        robot_array(rr).light_heading = ...
                wrapToPi(atan2(vec_light(2), vec_light(1))-...
                    robot_array(rr).orientation);
        % Run the robot logic
        robot_array(rr).runLogic
    end

    % Make all of the communication happen
    communication_handler(robot_array,6);

    movement_handler(robot_array, dt, robot_radius);

    clearDisplay();
    script_drawWorld;

   
   paths = drawPaths(paths, robot_array, 1,[0,0,1], true);

   simstep = simstep + 1;

   if(simstep > 500)
       exit_condition = true;
   end

end

paths = drawPaths(paths, robot_array, 1,[0,0,1], false);