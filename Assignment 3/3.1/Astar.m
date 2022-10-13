function [path, open_array, cost_array, from_array] = Astar(maze, maze_size, start_position, goal_position)
    % Here you will implement the A* algorithm. 
    % Inputs:
        % Maze is the represnetation of the cost associated with entering a
        % cell
        % maze_size is the overall maze_size of the maze
        % Start_position is the position of the start cell
        % goal_position is the position of the goal cell

    % Outputs:
        % Path is a 2xP array listing the path from the goal to the start
        % position (it's easier to implement this way), where P is the path
        % length. Essentially, after reaching the goal work backwards using
        % the from_array
        % Open array is an array of the same maze_size as the maze, listing
        % whether the node is open or closed
        % Cost array lists the cost of each node
        % From_array is a 3D array listing where each node was expanded
        % from.

    % Pre-allocate some arrays
    open_array = zeros(maze_size(1), maze_size(2));
    cost_array = zeros(maze_size(1), maze_size(2));
    from_array = zeros(maze_size(1),maze_size(2),2);
    
    % Begin A*. I've added some notes here to help
    current_node = start_position;

    while(~((current_node(1)==goal_position(1))&&(current_node(2)==goal_position(2))))
    
        % Add neighbors of current_node to the open set (i.e. the 8 surrounding
        % cells.
        for dx = -1:1:1
            for dy = -1:1:1
                if((dx == 0)&&(dy==0))
                    % Don't have to do anything
                else
                    % TODO: "Do only if this node hasn't been expanded
                    % before (i.e. it's not part of the open set and has no
                    % cost)
                        % TODO: Update the open set
                        % TODO: Evaluate the cost of the newly-added node and
                        % update the cost array
                        % TODO: Update the from_array
                end
            end

            % TODO: Remove current node from the open set

            % TODO: Find the lowest-cost member within the open set.
            % Easiest way to do this is just to loop through everything and
            % look for the minimum that way
        end

    end

    % TODO: Add nodes to the path
    path = [goal_position(1), goal_position(2)];

    while(~((path(end,1)==start_position(1))&&(path(end,2)==start_position(2))))
        % TODO: lookup the value of the from array of the last stored
        % position, add the from to the path using a line similar to:
        path = [path; from_array(xxxxx), from_array(yyyyy)];
    end

end