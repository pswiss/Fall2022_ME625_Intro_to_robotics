% Run this script once then save the output. Not a lot of comments here
% because it's not something you need to modify
rng(608);

dt = 0.1;
time = 250;
% Chance change
p = 0.1;

options_spin_speeds = [-pi/20, -pi/40, 0, pi/40, pi/20];
options_forward_speeds = [1, 2, 3];

commanded_spins = [];
commanded_drives = [];
selections = [3,2];

for ii = 0:dt:time
    commanded_spins = [commanded_spins; options_spin_speeds(selections(1))];
    commanded_drives = [commanded_drives; options_forward_speeds(selections(2))];
    
    if(rand < p)
        if(rand > 0.5)
            selections(1) = max(selections(1)-1, 1);
        else
            selections(1) = min(selections(1)+1, 5);
        end
    end

    if(rand < p)
        if(rand > 0.5)
            selections(2) = max(selections(2)-1, 1);
        else
            selections(2) = min(selections(2)+1, 3);
        end
    end
end
clear p dt time options_spin_speeds options_forward_speeds ii selections
% % % % % % % % %  save('command_drive.mat')
dt = 0.1;
drawRobotMotion(commanded_drives,commanded_spins,dt);