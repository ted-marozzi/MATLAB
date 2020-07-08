clear all

%Constants
I1 = 0.001;
I2 = 0.002;
k = 10;
b = 0.004;
Mcd = @(t) 10*sin(2*pi*100*t);

% Derivative function
odefn = @(T,X) [X(2); Mcd(T)/I1 - k/I1*X(1) - b/I1*X(2) + k/I1*X(3) + b/I1*X(4); X(4); k/I2*X(1) + b/I2*X(2) - k/I2*X(3) - b/I2*X(4)];
%odefn = @(T,X) [X(2); X(3); X(4); -2/3*X(1) - 5/3*X(2) - 2/3*X(3)];

% Initial state
X0 = [0;0;0;0];

% Simulate to equilibrium
[T,X] = ode45(odefn,[0,0.2],X0);
    
plot(T,X(:,1), T,X(:,3))