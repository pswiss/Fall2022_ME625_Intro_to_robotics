function [err_dist, err_heading] = error_of_pose(pos, orient, meas, landmark_position)
    % First, we calculate the overall distance of the position from all the landmarks
    % Note that we are using fancy matlab syntax o do this in one line
    dist_from_landmarks = sqrt(sum((landmark_position - pos).^2, 2));
    
    % Similarly, we use matlab syntax to calculate the unit vectors of each
    % position to each landmark.
    vector_to_landmarks = (landmark_position - pos)./dist_from_landmarks;
    % Turn this vector into an angle from north
    angle_to_landmarks = -wrapToPi(atan2(vector_to_landmarks(:,1),vector_to_landmarks(:,2))-pi/2);
    % Put this angle in terms of the orientation of the robot to get the
    % heading
    heading_to_landmarks = wrapToPi(orient - angle_to_landmarks);
    
    meas_heading = meas(4);
    meas_distance = meas(3);
    
    % Calculate the errors
    err_heading = wrapToPi(meas_heading - heading_to_landmarks);
    err_dist = meas_distance - dist_from_landmarks;
end

