function [ x,y ] = FDM_Project2(a,b,h,alpha,beta,w,T,M)
%Gives solution to how much deflection is occuring at each point x
% a=0,b=120,alpha=0,beta=0
%From initial conditions of a W12x22 structural steel I-beam--> 
%L=120,E=29*10^6,I=121. 
%This code allows for different weight loads on beam (w) and end tension
%(T)

N = (b-a)/h;
L = 120;
E = 29*10^6;
I = 121;
A = T/(E*I);
B = w/(2*E*I);

x = a:h:b;
y = zeros(N+1,1);
y(1) = alpha; y(N+1) = beta;
for j=1:M
    for i=2:N
        y(i)= (y(i+1) + y(i-1) - h^2*B*x(i)*(L-x(i)))/(h^2*A + 2);
    end
end
plot(x,y,'o-');
hold on

xx = a:0.001:b;
yy =(-2*B/A^2)*(exp(sqrt(A)*L)/(exp(sqrt(A)*L)+1))*exp(-sqrt(A)*xx)+(-2*B/A^2)*(1/(exp(sqrt(A)*L)+1))*exp(sqrt(A)*xx)+(B/A)*xx.^2-(L*B/A)*xx+(2*B/A^2);
plot(xx,yy,'Color','r');

title('Numerical Solutions by FDM Relaxation Method');
legend('Numerical Solution','Exact Solution','Location','northwest');
xlabel('Point x(i) on Beam');
ylabel('Deflection');

end

