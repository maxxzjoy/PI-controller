function [cost,c] = costfunction ( kp, ki )
%----------------------------%
% input parameter
r = 10 ; % true value
theta = 0 ; % initial value
EA = 0 ; % sum of error
T = 0.1 ; % sampling rate
a = 3 ; 
b = 20 ; 
cost = 0;
%----------------------------%
x=1;
for i = 1 :0.1: 10
    E = r - theta ;
    EA = EA + E*T ;
    U = kp*E + ki*EA ;
    theta = theta + T*( b*U - a*theta );
    cost = cost + E^2 ;
    c(x)=theta;
    x=x+1;
end

end