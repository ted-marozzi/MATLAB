clc
clear

K = [33000, -13000, 0; -13000, 22000, -9000; 0, -9000, 9000];

M = [10, 0, 0; 0, 40, 0; 0, 0, 30];

syms lambda x1 x2 x3

[PHI,omn] = eig(K,M)

nat_freq_squared = omn*[1;1;1]


nat_freq = sqrt(omn*[1;1;1])

eigvecs_trans = transpose(PHI);

M_norm = eigvecs_trans*M*PHI;

K_norm = eigvecs_trans*K*PHI;


z0 = inv(PHI)*q0;
z0dot = inv(PHI)*q0dot;
z1 = [z0(1,1)*cos(9.6272*5);0 ;0]




