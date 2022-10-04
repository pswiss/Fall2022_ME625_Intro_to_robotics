%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ME 625 Assignment 2
% Name: Your Name
% Run file for part # [put what section this run is for]

% A few examples 
% Flocking / Boids:         https://www.youtube.com/watch?v=QbUPfMXXQIY
% Hop Localization:         https://www.youtube.com/watch?v=K2DWJeIYEho
% Brazil Nut effect:        https://drive.google.com/file/d/1C9mxYO1rKvDVYFys4CV_mAD6rBNxE3DK/view?usp=sharing
% Distributed behaviors:    https://www.youtube.com/watch?v=GnyDAuqorGo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all;
dt = 0.01;
robot_radius = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First, Initialize the system
robot_array = placeRobots();

light_location = [0,0];

script_drawWorld

exit_condition = false;

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

   
   drawPaths(robot_array,[1,2,3]);

   simstep = simstep + 1;

   if(simstep > 550)
       exit_condition = true;
   end

end

drawPaths(robot_array,[1,2,3]);