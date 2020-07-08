% mdof_time.m
% create mass, stiffness and damping matrices

K = [33000, -13000, 0; -13000, 22000, -9000; 0, -9000, 9000];

M = [10, 0, 0; 0, 40, 0; 0, 0, 30];
a = 0.0; b = 0.0; 
% constants for proportional damping:
% find eigenvalues and eigenvectors
[PHI,omn] = eig(K,M); omn = sqrt(diag(omn));


zeta = (a + b*omn.^2) ./ omn / 2;

lambda(1:2:2*N) = -zeta.*omn + omn.*sqrt(zeta.^2-1);
lambda(2:2:2*N) = -zeta.*omn - omn.*sqrt(zeta.^2-1);
lambda = sort(lambda);

A = [zeros(N) eye(N); -M\K -M\C]; B = [zeros(N); inv(M)]; C = eye(2*N);

G = ss(A,B,C,0);

q0 = [0; 0; 0; 0];

t = [ 0 : 0.01 : 20 ];

omf = 1. * omn(2); amp = 1;

f = [1.0*cos(2.2*t); 0*t];

q = lsim(G,f,t,q0);
q = q(:,1:N)';

z = PHI \ q;

figure, set(gca,'Box','On','XMinorTick','On','YMinorTick','On');

subplot(211), plot(t,q), xlabel('t'), ylabel('q(t)')
subplot(212), plot(t,z), xlabel('t'), ylabel('z(t)')












