dt = 0.001;
% initial conditions
t(1) = 0;
vx(1) = 3.809*cos(45);
vy(1) = 3.809*sin(45);
rx(1) =0;
ry(1) = 0.21;
i=1;
while ry(i) > 0
ax = 0; % expression for x-component of acceleration
ay = -9.81; % expression for y-component of acceleration
t(i+1) = t(i)+dt
vx(i+1) = vx(i)+ax*dt;
vy(i+1) = vy(i)+ay*dt;
rx(i+1) = rx(i)+vx(i)*dt+ax*0.5*dt*dt;
ry(i+1) = ry(i)+vy(i)*dt+ay*0.5*dt*dt;
i=i+1;
end