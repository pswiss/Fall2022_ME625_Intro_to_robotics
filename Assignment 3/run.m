% Assignment 3.1: A*
% In this assignment you will be implementing the A* algorithm. Most of
% your work will be done in some of the functions called here, but you
% might need to add some things in the main run file depending on what you
% want to do
clc
clear all
close all

[maze, maze_size, start_position, goal_position] = loadMaze(1);

% [path, open_array, cost_array, from_array] = Astar(maze, maze_size, start_position, goal_position);
open_array = zeros(maze_size(1), maze_size(2));
cost_array = zeros(maze_size(1), maze_size(2));
from_array = zeros(maze_size(1),maze_size(2),2);
path = [2,2;2,3;2,4;3,4];


drawMaze(maze, maze_size, start_position, goal_position, path, open_array, cost_array, from_array);