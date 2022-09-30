function drawRobotLink_xzCoincident(T, length, w, h, color)
    % This function draws a 3D box representing a robot link. This link is
    % oriented such that the 'length' of the link is along the x-axis and 
    % the cross-section of the link is defined as 'w' x 'h'. The box is 
    % drawn using the color specified by 'color', which should be provided
    % in RGB. For now, the box is drawn centered on T (HINT: you might want
    % to change this)
    
    % Define a representative cube with unit dimensions centered on T.
    % Don't worry about understanding this; drawing these things in matlab
    % is confusing and I barely understand it myself.
    vert = [        -.5    -0.5000   -0.5000;
                     .5    -0.5000   -0.5000;
                     .5     0.5000   -0.5000;
                    -.5     0.5000   -0.5000;
                    -.5    -0.5000    0.5000;
                     .5    -0.5000    0.5000;
                     .5     0.5000    0.5000;
                    -.5     0.5000    0.5000];
    faces = [   1, 2, 6, 5;...
                2, 3, 7, 6;...
                3, 4, 8, 7;...
                4, 1, 5, 8;...
                1, 2, 3, 4;...
                5, 6, 7, 8];
            
  %shift the points
  vert(:,2)=vert(:,2)+ .5;
  % Scale the box
    vert = vert.*[length, w, h];
    
    % Transform box vertices
    for ii = 1:size(vert, 1)
        temp = T*[vert(ii, :), 1]';
        vert(ii, :) = temp(1:3);        
    end
            
    % Draw the box
    patch('Vertices',vert,'Faces',faces,...
      'FaceColor',color, 'FaceAlpha', 1, 'EdgeColor', color*0.2, 'FaceLighting', 'flat',   'AmbientStrength',0.7)

end