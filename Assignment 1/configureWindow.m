function configureWindow()
    % Configure Camera
    set3DView([10, 10, 10], [0, 0, 0]);
    
    % Set window aspect ratio
    daspect([1,1,1]);
    
    % Set window limits
    xlim([-10, 10]);
    ylim([-10, 10]);
    zlim([-10, 10]);
    
    % Other parameters
    figsize = [4,4,1.25*30,1.25*22*.75];
    set(gcf, 'Color', 'white','Units','centimeters','Position',figsize)
    lightangle(gca,45,30)
    
    % Force draw
    drawnow limitrate;
end

