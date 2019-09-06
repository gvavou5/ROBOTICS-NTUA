function [X, Y, Z] = LocDet( q1,q2,q3,l1,l2,l3 )
    X = l2*cos(q1)*cos(q2) - l3*sin(q1)*sin(q3) + l3*cos(q1)*cos(q2)*cos(q3);
    Y = l2*sin(q1)*cos(q2) + l3*cos(q1)*sin(q3) + l3*sin(q1)*cos(q2)*cos(q3);
    Z = l1+l2*sin(q2)+l3*sin(q2)*cos(q3);
end

