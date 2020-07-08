m = 100;
c = 100;
k = 5e5;
g = 9.81;

m_2 = 500; % Extra mass placed on platform

% Gravitational force alone acts on the mass
F = -m_2*g;

odefn = @(T,X) [X(2); 1/m*(F - c*X(2) - k*X(1))];
X0 = [0;0];

[T,X] = ode45(odefn,[0,10],X0);
plot(T,X(:,1)+2);

fprintf('%f',2+X(end,1))