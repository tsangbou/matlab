function [x,y,z]=beam_with_tension_shooting(h,w,T,gamma)
    %hardcode in teh constants
    L = 120;
    E = 29*10^6;
    I = 121;
    alpha = T/(E*I);
    beta = w/(2*E*I);
    N = L/h; 
    x = zeros(N+1,1);
    y = zeros(N+1,1); 
    z = zeros(N+1,1); 
    x(1) = 0; 
    y(1) = 0; 
    z(1) = gamma; 
    for i = 1:N
        y(i+1) = y(i) + h*z(i);
        z(i+1) = z(i) + h * (beta*x(i)*(L-x(i)) + alpha*y(i));
        x(i+1) = x(i) + h;
    end
end