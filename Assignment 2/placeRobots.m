function robot_array = placeRobots()
    
    % Let's just directly define robots here but you can do this in a loop
    % (you should *probably* do this in some sort of loop). The big thing
    % you need to make sure of is that you don't place robots inside each
    % other.
    % Here, we're going to build out robot_array one bit at a time. You
    % should probably do something like this if you're using a loop
    robot_array = [];

    % Robot initialization: robot( [position x, position y], angle, role)
    robot_array = [robot_array, robot([0,0],    0,  1)];
    robot_array = [robot_array, robot([5,0],    0,  2)];
    robot_array = [robot_array, robot([2.5,3],  0,  3)];
    robot_array = [robot_array, robot([-5,-5],  0,  4)];
    robot_array = [robot_array, robot([-5,5],   0,  5)];

    

end