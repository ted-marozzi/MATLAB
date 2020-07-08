clear all

% Derivative function
odefn = @(T,X) [
    X(2);
    X(3); 
    -2/3*X(1) - 5/3*X(2) - 2/3*X(3)];

% Initial state
X0 = [1;0;0];

% Simulate to equilibrium
[T,X] = ode45(odefn,[0,50],X0);

plot(T,X(:,1))