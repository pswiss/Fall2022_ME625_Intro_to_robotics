function drawCsys3D(T, scale)
    % This function takes in transformation matrix T and will draw the 
    % associaited coordinate system in 3D space using the plot command. 
    % Scale controls the size of the displayed coordinate system (scale = 1
    % corresponds to the default length)
    
    % Define colors
    x_color = [1, 0, 0];
    y_color = [0, 1, 0];
    z_color = [0, 0, 1];
    
    % Get the origin of the transformation matrix
    p_o = T(1:3, 4);
    
    % Draw the coordinate system
    hold on
    daspect([1,1,1]);
    
    % X axis
    plot3(  [p_o(1), p_o(1)+T(1,1)*scale],...
            [p_o(2), p_o(2)+T(2,1)*scale],...
            [p_o(3), p_o(3)+T(3,1)*scale] , 'Color', x_color);
        
    plot3(  [p_o(1), p_o(1)+T(1,2)*scale],...
            [p_o(2), p_o(2)+T(2,2)*scale],...
            [p_o(3), p_o(3)+T(3,2)*scale] , 'Color', y_color)
        
    plot3(  [p_o(1), p_o(1)+T(1,3)*scale],...
            [p_o(2), p_o(2)+T(2,3)*scale],...
            [p_o(3), p_o(3)+T(3,3)*scale] , 'Color', z_color)
        
end

