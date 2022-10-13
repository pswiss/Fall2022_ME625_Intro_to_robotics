function drawBox(node, maze, start_position, goal_position, open_array, cost_array, from_array)
    % This function draws a box with some text on it
    x = node(1);
    y = node(2);
    maze_node = maze(x,y);

    % set color
    if(maze_node == 0)
        color = [1,1,1];
    elseif(maze_node >100)
        color = [1,0,0];
    else
        color = [1,1,0];
    end
    if((goal_position(1)==x)&&(goal_position(2)==y))
        color = [0,1,0];
    end
    if((start_position(1)==x)&&(start_position(2)==y))
        color = [0,0.4,1];
    end

    % draw the box
    rectangle('Position',[x,y,1,1],'FaceColor',color);

    % Add the text
% %     text(x,y+0.05,sprintf("%d,%d",from_array(x,y,1), from_array(x,y,2)))
% %     text(x,y+0.05+0.5,sprintf("%f",cost_array(x,y)));
% %     text(x+0.5,y+0.05+0.5,sprintf("%d",open_array(x,y)));
end