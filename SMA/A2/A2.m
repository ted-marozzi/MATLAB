format long

r = 0.02;
L = 0.2;
m = 0.2;
J1 = 6.25*10^-4;
J2 = 8*10^-4;
k = 10;
c = 0.1;
cp = 1;
Ra = 10;
La = 0;
kt = 1;
ke = 1;
K = [100, 200, 500, 800, 1000, 1500];
syms x

s = tf('s'); 
%{
A = [ J1*s^2 + c*s + 3*k*r^2, -k*r^2, -2*k*r, -kt;
    -k*r^2, J2*s^2 + c*s + 3*k*r^2, -2*k*r, 0;
    -2*r*k, -2*k*r, m*s^2 + cp*s+4*k, 0;
    ke*s, 0, 0, La*s + Ra];

G = A\[0;0;0;1];

Gol = G(3,1);


Gol


t = 0:0.0001:20;

u = 1 + 0*t;

sim = lsim(Gol, u, t);


ci = sim(10/0.0001);
cii = sim(20/0.0001);
min(real(pole(Gol)));
abs(min(real(pole(Gol))));
p = pole(Gol);
disp("**************************")
for i = 1:length(K)
    
    
    
    
    B = [J1*s^2 + c*s + 3*k*r^2, -k*r^2, -2*k*r, -kt;
        -k*r^2, J2*s^2 + c*s + 3*k*r^2, -2*k*r, 0;
        -2*r*k, -2*k*r, m*s^2 + cp*s+4*k, 0;
        ke*s/K(i), 0, 1, (La*s + Ra)/K(i)];
    
    G = B\[0;0;0;1];
    Gcl = G(3,1);
    KK = K(i);
    pole(Gcl);
    

    if K(i) == 100 || K(i) == 500 || K(i) == 1000
        %fprintf("The max transfer poles of Gcl for K =")
        %disp(K(i));
      
        max_pol = max(real(pole(Gcl)));
        
        
    end
    if K(i) == 200 || K(i) == 800 || K(i) == 1500
        %fprintf("The max transfer zeros of Gcl for K =")
        %disp(K(i));
        max_zero = max(real(zero(Gcl)));
    end
    
    t = 0:0.0001:10;
    u = 0.1 + 0*t;
    sim = lsim(Gcl, u, t);
    %figure(K(i))
    %plot(t,sim)
    KK = K(i);
    last_val = sim(length(sim))-0.1;
    
    
        
end

    %}
    

A = [ J1*s^2 + c*s + 3*k*r^2, -k*r^2, -2*k*r, -kt;
    -k*r^2, J2*s^2 + c*s + 3*k*r^2, -2*k*r, 0;
    -2*r*k, -2*k*r, m*s^2 + cp*s+4*k, 0;
    ke*s, 0, 0, La*s + Ra];


G = A\[0;0;0;1];
Gol = G(3,1);

Gol_num = 320*x^2 + 40000*x + 6400;
Gol_denom = x^6 + 450*x^5 + 42459*x^4 + 296371*x^3 + 8040816*x^2 + 961280*x; 
Gol_num_fac  = factor(Gol_num,x,'FactorMode', 'real');
Gol_denom_fac = factor(Gol_denom,x, 'FactorMode', 'real');


approx_Gol = ((1/200.3763088481459126467964084376)*s + (0.16020532597175773723339034321156/200.3763088481459126467964084376))/(s^2+0.12*s);
approx_Gol
t = 0:0.0000001:10;
approx = impulse(approx_Gol, t);


real_fn = impulse(Gol, t);

y_1 = approx(0.5/0.0000001) - real_fn(0.5/0.0000001);
disp(y_1)

y_2 = approx(2.0/0.0000001) - real_fn(2.0/0.0000001);
disp(y_2)







