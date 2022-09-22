function [twist,theta] = TToTwist(T)
    R = getRFromT(T);
    p = getPFromT(T);

    % See section 3.2.3.3
    if NearZero(norm(R - eye(3)))
        twist = [0;0;0;T(1:3,4)];
    else
        acosinput = (trace(R) - 1) / 2;
        if acosinput > 1
            acosinput = 1;
        elseif acosinput < -1
            acosinput = -1;
        end
        theta = acos(acosinput);
    
        if NearZero(norm(R - eye(3)))
	        w_skew = zeros(3);
        elseif NearZero(trace(R) + 1)
            if ~NearZero(1 + R(3,3))
                omg = (1 / sqrt(2 * (1 + R(3,3)))) * [R(1,3); R(2,3); 1 + R(3,3)];
            elseif ~NearZero(1 + R(2,2))
                omg = (1 / sqrt(2 * (1 + R(2,2)))) * [R(1,2); 1 + R(2,2); R(3,2)];
            else
                omg = (1 / sqrt(2 * (1 + R(1,1)))) * [1 + R(1,1); R(2,1); R(3,1)];
            end
            w_skew = VecToso3(pi * omg);
        else
            acosinput = (trace(R) - 1) / 2;
            if acosinput > 1
                acosinput = 1;
            elseif acosinput < -1
                acosinput = -1;
            end
            theta = acos(acosinput);
            w_skew = theta * (1 / (2 * sin(theta))) * (R - R');
        end
    
        % See Section 3.3.3.2
        v = (eye(3) - w_skew / 2 ...
                            + (1 / theta - cot(theta / 2) / 2) ...
                              * w_skew * w_skew / theta) * p;
    
        w = [w_skew(3,2);w_skew(1,3);w_skew(2,1)];
    
        twist = [w;v];

    end
end