classdef msg < handle
    % This class is basically a container for messages that robots send to
    % each other. 

    properties
        number_to_send
        distance
        heading
    end

    methods
        function self = msg(n_to_send)
            self.number_to_send = n_to_send;
        end

        function addDistanceInfo(self, distance, heading)
            self.distance = distance;
            self.heading = heading;
        end
    end
end