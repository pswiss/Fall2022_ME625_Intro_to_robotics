function drawRobotMotion(forwards,spins, dt,how)
    % Basically, integrate. Not a lot of comments since there's nothing
    % here you need to modify
    position = zeros(length(spins),2);
    orientation = zeros(length(spins),1);
    for ii = 2:length(spins)
        orientation(ii) = orientation(ii-1) + spins(ii)*dt;
        position(ii,:) =  position(ii-1,:) + forwards(ii)*[cos(orientation(ii)), sin(orientation(ii))];
    end
    
    
    plot(position(:,1), position(:,2),how, "LineWidth",3)
    daspect([1,1,1])
end