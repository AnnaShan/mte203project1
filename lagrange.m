function F = lagrange(in)
    syms x y z
    f = temperature(x,y,z);
    g = terrain(x,y)-z;
    grad_f = gradient(f,[x,y,z]);
    grad_g = gradient(g,[x,y,z]);
    F(1) = double(subs(grad_f(1),[x,y,z],[in(1),in(2),in(3)]) ...
        - in(4)*subs(grad_g(1),[x,y,z],[in(1),in(2),in(3)]));
    F(2) = double(subs(grad_f(2),[x,y,z],[in(1),in(2),in(3)]) ...
        - in(4)*subs(grad_g(2),[x,y,z],[in(1),in(2),in(3)]));
    F(3) = double(subs(grad_f(3),[x,y,z],[in(1),in(2),in(3)]) ...
        - in(4)*subs(grad_g(3),[x,y,z],[in(1),in(2),in(3)]));
    F(4) = double(subs(g,[x,y,z],[in(1),in(2),in(3)]));
end