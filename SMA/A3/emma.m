syms x
K =[ 33000 -13000 0; -13000 22000 -9000; 0 -9000 9000];
M = [ 10 0 0; 0 40 0; 0 0 30];
[v,d] = eig(K,M);
mode1 = v(:,1);
mode2 = v(:,2);
mode3 = v(:,3);
moderatio = v(:,1)./v(:,2)
q0 = [1;mode1(2,1)/mode1(1,1);mode1(3,1)/mode1(1,1)];
q0dot = [0;0;0];
mhat = v.'*M*v;
psi1 = 1/sqrt(mhat(1,1)).*mode1;
psi2 = 1/sqrt(mhat(2,2)).*mode2;
psi3 = 1/sqrt(mhat(3,3)).*mode3;

lantern = [psi1, psi2,psi3];

z0 = inv(lantern)*q0;
z0dot = inv(lantern)*q0dot;
z1 = [z0(1,1)*cos(9.6272*5);0 ;0]