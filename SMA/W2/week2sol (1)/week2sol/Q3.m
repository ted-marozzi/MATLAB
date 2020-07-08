clear all

%%%%%%%%%%
% Workshop1.m
% written by Rohan Shekhar
% Code to simulate mass-spring-damper system
%%%%%%%%%%


% Constants
m = 100;
c = 100;
k = 5e5;
g = 9.81;   

%% Part a

% state vector: X = [x, v] (i.e. position and velocity)

% As a system of First-order equations:
% Xdot = [v; 1/m*(F - c*v - k*x)]


%% Part b

m_2 = 500; % Extra mass placed on platform

% Gravitational force alone acts on the mass
F = -m_2*g;

% Derivative function
odefn = @(T,X) [X(2); 1/m*(F - c*X(2) - k*X(1))]; % Two first-order ODEs

% Initial state
X0 = [0;0];

% Simulate to equilibrium
[T,X] = ode45(odefn,[0,10],X0);

% Plot to determine equilibrium (add 2m for the initial height)
plot(T,X(:,1)+2);

% Output the equilibrium height (add 2m for the initial height)
fprintf('equilibrium height under load: %.2f\n',2+X(end,1));

pause;

%% Part c

% Sinusoidal force
F = @(t) 1e5*sin(2*pi*5*t);

% Derivative function
odefn = @(T,X) [X(2); 1/m*(F(T) - c*X(2) - k*X(1))];

% Initial state
X0 = [0;0];

% Simulate to steady-state
[T,X] = ode45(odefn,[0,10],X0);

% Plot to determine frequency response
plot(T,X(:,1)+2);

% Find the amplitude of the steady-state response (assume ss reached after 7 s)
fprintf('Approximate steady-state response amplitude: %.2f\n',max(X(T>7,1)));
pause;

%% Part d
freqs = [1:10,20:10:50];
magnitude = zeros(length(freqs),1);
for i = 1:length(freqs);
   F = @(t) 1e5*sin(2*pi*freqs(i)*t);

   % Derivative function
   odefn = @(T,X) [X(2); 1/m*(F(T) - c*X(2) - k*X(1))];
    
   % Simulate to steady-state
    [T,X] = ode45(odefn,[0,10],X0);
    
    % Create a plot of the response (optional)
    % plot(T,X(:,1));
    % pause;
    
    % Determine peak oscillation after steady state is reached (say after 7
    % sec)
    magnitude(i) = max(X(T>7,1));
end

loglog(freqs,magnitude);
pause;

%% Part e 
cs = [100:100:1000,1500,2000]; % Damping values
magnitude = zeros(length(cs),1); % Magnitude vector
for i = 1:length(cs);
   F = @(t) 1e5*sin(2*pi*10*t);

   % Derivative function
   odefn = @(T,X) [X(2); 1/m*(F(T) - cs(i)*X(2) - k*X(1))];
    
   % Simulate to steady-state
    [T,X] = ode45(odefn,[0,15],X0);
    
    % Create a plot of the response (optional)
    % plot(T,X(:,1));
    % pause;
    
    % Determine peak oscillation after steady state is reached
    magnitude(i) = max(X(T>12,1));
end

loglog(cs,magnitude);