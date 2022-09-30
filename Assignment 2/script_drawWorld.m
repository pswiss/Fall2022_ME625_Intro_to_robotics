% This script is going to draw all of the robots

% Loop through all the robots and have them draw themselves
for(ll = 1:length(robot_array))
    robot_array(ll).drawSelf();
end

% Set window bounds
daspect([1,1,1])
xlim([-10,20]);
ylim([-10,10]);
grid on;

[xy,h] = createStarVertices(gca, 4, light_location);
h.FaceColor = 'y';  h.FaceAlpha = .4;

% Some debug stuff to put text on the plot
p = robot_array(1).position;
text(p(1)+1, p(2), "\leftarrow Moves forward while turning slightly");

p = robot_array(3).position;
text(p(1)+1, p(2), "\leftarrow Turns to face neighbors");

p = robot_array(2).position;
text(p(1)+1, p(2), "\leftarrow Changes color based on proximity");

p = robot_array(4).position;
text(p(1)+1, p(2), "\leftarrow Turns to face the light source");

p = robot_array(5).position;
text(p(1)+1, p(2), "\leftarrow Turns to face North");

drawnow