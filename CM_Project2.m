function [x,y]=CM_Project2(a,b,h,alpha,beta,w,T)
%Gives solution to how much deflection is occuring at each point x
% a=0,b=120,alpha=0,beta=0
%From initial conditions of a W12x22 structural steel I-beam--> 
%L=120,E=29*10^6,I=121. 
%This code allows for different weight loads on beam (w) and end tension
%(T)
%alpha (aa)=T/EI and beta (bb)=w/2EI below
N=(b-a)/h;
x=a:h:b;
A=zeros(N+1,N+1);
A(1,1)=1;
for k=1:N+1
A(N+1,k)=120^(k-1);
end
g=zeros(N+1,1);
g(1)=alpha; g(N+1)=beta;
for i=2:N
    for j=1:N+1
        A(i,j)=(j-1)*(j-2)*x(i)^(j-3)-(T/(3.509*10^9))*x(i)^(j-1);
    end
end
for m=2:N
    g(m)=(w/(2*3.509*10^9))*x(m)*(120-x(m));
end
c=A\g;
syms t
y=c(1)*1;
for i=1:N
    y=y+c(i+1)*t^i;
end
ezplot(y,[a,b]);
hold on
aa=(T/(3.509*10^9)); %alpha=T/EI
bb=(w/(2*3.509*10^9)); %beta=w/2EI
xx=a:0.001:b;
yy=(-2*bb/aa^2)*(exp(sqrt(aa)*120)/(exp(sqrt(aa)*120)+1))*exp(-sqrt(aa)*xx)+(-2*bb/aa^2)*(1/(exp(sqrt(aa)*120)+1))*exp(sqrt(aa)*xx)+(bb/aa)*xx.^2-(120*bb/aa)*xx+(2*bb/aa^2);
plot(xx,yy,'Color','r');
title('Numerical Solutions by Collocation Method');
legend('Numerical Solution','Exact Solution','Location','northwest');
xlabel('Point X on Beam');
ylabel('Deflection');
end