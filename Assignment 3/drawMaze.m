function drawMaze(maze, maze_size, start_position, goal_position, path, open_array, cost_array, from_array)
    figure
    daspect([1,1,1])
    hold on
    % Draw the boxes
    for xx = 1:maze_size(1)
        for yy = 1:maze_size(2)
            drawBox([xx,yy], maze, start_position, goal_position, open_array, cost_array, from_array)
        end
    end

    % Draw the path
    plot(path(:,1)+0.5,path(:,2)+0.5,'LineWidth',3,'Color',[0,0,0]);
end