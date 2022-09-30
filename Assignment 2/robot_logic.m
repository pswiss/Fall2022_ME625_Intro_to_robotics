classdef robot_logic < handle
    % This is the main class you will be modifying to change the behavior
    % of the robot
    
    properties
        % Properties
        id = 0;
        role = 0;

        % Output Values
        out_color = [0,0,0];
        out_spin = 0;
        out_drive = 0;

        % Measured Values
        in_light_heading;
        in_compass;
        
        % Communication Values
        comm_in = [];
        comm_out = [];

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Logic values

        % PUT STUFF HERE

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    methods
        % Initialization
        function self = robot_logic(role,id)
            self.role = role;
            self.id = id;
            self.comm_out = msg(self.id);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % This is the bit to modify
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function [out_drive, out_spin] = runLogic(self, in_light_heading, in_compass)
            self.in_light_heading = in_light_heading;
            self.in_compass = in_compass;
            % Here's an example of how to use multiple roles
            if(self.role == 1)
                % Role 1: Example of how a robot can move forward with a
                % slight turn
                self.out_drive = 0.1;
                self.out_spin = 1;
                self.comm_out = msg(self.id);
%                 self.comm_out.favorite_color = "green"
                self.in_compass
            end
            if(self.role == 2)
                % Role 2: Example of how a robot can change its color based
                % on the closest robot
                self.out_drive = 0;
                self.out_spin = 0;
                self.comm_out = msg(self.id);
                n_msg = length(self.comm_in);
                % Find the minimum distance
                if(n_msg >0)
                    min_dist = self.comm_in(1).distance;
                    for ii = 2:n_msg
                        min_dist = min(self.comm_in(ii).distance, min_dist);
                    end

                    distance_ratio = min(min_dist/5,1);
                    self.out_color = hsv2rgb(distance_ratio, 1,0.8);
                end
            end
            if(self.role == 3)
                % Role 3: Turn to face the average location of observed
                % neighbors
                self.out_drive = 0;
                self.comm_out = msg(self.id);
                self.out_spin = 0;

                n_msg = length(self.comm_in);
                % Find the average_heading
                if(n_msg >0)
                    avg_heading = 0;
                    for ii = 1:n_msg
                        avg_heading = avg_heading + self.comm_in(ii).heading;
                    end
                    avg_heading = avg_heading / n_msg;

                    self.out_spin = sign(avg_heading);
                end                
            end
            if(self.role == 4)
                % Role 4: Turn to face the light location
                self.out_drive = 0;
                self.comm_out = msg(self.id);

                self.out_color = [0,0,1];

                self.out_spin = 0.25*sign(self.in_light_heading);
            end
            if(self.role == 5)
                % Role 5: Turn to face North
                self.out_drive = 0;
                self.comm_out = msg(self.id);
                self.out_color = [.8,.5,0];

                self.out_spin = -0.5*sign(self.in_compass);
            end

            out_drive = self.out_drive;
            out_spin = self.out_spin;
            self.clearCommIn();
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function clearCommIn(self)
            self.comm_in = [];
        end

        function loadComm(self,msg_in)
            self.comm_in = [self.comm_in; msg_in];
        end
    end
end

