classdef robot < handle
    % This is the robot class that contains various robot properties and
    % abstracts away the implementation details

    properties
        % Physical Properties
        position = [0,0]; % x/y position
        orientation = [0]; % radians
        
        % Robot properties
        radius = 1;
        lw = 2

        % Outputs
        out_drive;        % Forward/Backward Motion
        out_spin;           % Rotational Motion
        out_color = [0,0,0] % RGB

        % Inputs
        light_heading  =   0;

        % Communication
        comm_out    = [];
        comm_in     = [];

        % Other objects
        logic 
    end

    methods
        function self = robot(initial_position, initial_orientation, role)
            self.position = initial_position;
            self.orientation = initial_orientation;
            self.logic = robot_logic(role, randi(1e9));
            self.radius = 1;
        end

        function runLogic(self)
            self.logic.loadComm(self.comm_in);
            [self.out_drive, self.out_spin] = ...
                self.logic.runLogic(self.light_heading, self.orientation);
            self.comm_out = self.logic.comm_out;
        end

        function drawSelf(self)
            % Draws a representation of the robot
            circle_x_coords = self.radius*cos(0:pi/8:(2*pi)) + self.position(1);
            circle_y_coords = self.radius*sin(0:pi/8:(2*pi)) + self.position(2);
            hold on
            plot(circle_x_coords, circle_y_coords, '-', 'Color', self.logic.out_color, 'LineWidth',self.lw);
            plot(self.position(1)+[0,cos(self.orientation)],...
                self.position(2)+[0,sin(self.orientation)],...
                '-','Color',self.logic.out_color, 'LineWidth',self.lw);
        end

        function clearCommIn(self)
            self.comm_in = [];
        end

        function loadCommIn(self, new_comm_in)
            self.comm_in = [self.comm_in; new_comm_in];
        end
    end
end