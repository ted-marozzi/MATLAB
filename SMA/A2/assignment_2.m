syms r L m J k c cp Ra La kt ke y(t) theta1(t) theta2(t) ia(t) V(t) s
dtheta1 = diff(theta1, t);
d2theta1 = diff(theta1, t, 2);

dtheta2 = diff(theta2, t);
d2theta2 = diff(theta2, t, 2);

dy = diff(y, t);
d2y = diff(y, t, 2);

dia = diff(ia,t);

eqn1 = J*d2theta1 + c*dtheta1 + 3*k*r^2*theta1 - 2*k*r*y - kt*ia == 0;
eqn2 = J*d2theta2 +c*dtheta2 + 3*k*r^2*theta1 - 2*k*r*y == 0;
eqn3 = m*d2y +cp*dy + 4*k*y - 2*k*r*theta1 - 2*k*r*theta2 == 0;
eqn4 = La*dia + Ra*ia + Ra + ke*dtheta1 == V;

cond1 = y(0) == 0;
cond2 = theta1(0) == 0;
cond3 = theta2(0) == 0;
cond4 = ia(0) == 0;
cond5 = V(0) == 0;

eqn1LT = laplace(eqn1, t, s);
eqn2LT = laplace(eqn2, t, s);
eqn3LT = laplace(eqn3, t, s);
eqn4LT = laplace(eqn4, t, s);

laplace(J*d2theta1 + c*dtheta1 + 3*k*r^2*theta1 - 2*k*r*y - kt*ia == 0)


syms Y_LT THETA1_LT THETA2_LT IA_LT V_LT
eqn1LT = subs(eqn1LT, [laplace(theta1(t),t,s) laplace(y(t),t,s) ])


