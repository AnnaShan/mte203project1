% Part 1
%% a. Surface plot of terrain
% Define function
syms x y
ezsurf(@terrain,[-5,5,-2,4])
% Add labels
title('Surface Plot of Terrain');
xlabel('X');
ylabel('Y');
zlabel('Z');
% Save plot
saveas(gcf,'SurfacePlot.png')
%% a. Contour plot of terrain
[x,y] = meshgrid(-5:0.1:5,-2:0.1:4);
[c,h] = contour(x,y,terrainMatrix(x,y),25);
% Add labels
title('Contour Plot of Terrain');
xlabel('X');
ylabel('Y');
clabel(c,h);
% Save plot
saveas(gcf,'ContourPlot.png')
%% b. Point of steepest slope
% Compute gradient of terrain function
[x,y] = meshgrid(-5:0.001:5,-2:0.001:4);
[gx,gy] = gradient(terrainMatrix(x,y));
% Find length of gradient
length = sqrt(gx.^2 + gy.^2);
% Find location of maximum gradient length
maximum = max(max(length));
[maxi,maxj] = find(length==maximum);
% Convert to x and y values
max_x = -5 + 0.001*maxj
max_y = -2 + 0.001*maxi
%% c. Critical points of terrain
syms x y
z = terrain(x,y);
% Compute first derivatives
dzdx = diff(z,x);
dzdy = diff(z,y);
% Define function to solve
fun = @terrainPartials;
% Create matrix of initial guesses
[a0, b0] = meshgrid(-5:0.5:5,-2:0.5:4);
a0 = reshape(a0,[],1);
b0 = reshape(b0,[],1);
x0 = [a0, b0];
% Create solutions matrix
sol = [];
% Decrease fsolve function tolerance
options = optimoptions('fsolve','TolFun',1E-15);
for i = 1:size(x0,1)
    t = fsolve(fun,x0(i,:),options);
    % Set bounds for solution matrix
    if t(1) < 5 && t(1) > -5 && t(2) < 4 && t(2) > -2
        % Round solution to remove float truncation error
        t = round(t,3);
        % Remove duplicate solutions
        if ~ismember(t, sol)
            sol = [sol; t];
        end
    end
end
%% Compute f(x,y)
f = zeros(size(sol,1),1);
for i = 1:size(sol,1)
    f(i) = round(terrain(sol(i,1), sol(i,2)),3);
end
disp(f);
%% Compute A
A = zeros(size(sol,1),1);
f_xx = diff(dzdx,x);
for i = 1:size(sol,1)
    A(i) = round(double(subs(f_xx,[x,y],sol(i,:))),3);  
end
disp(A);
%% Compute B
B = zeros(size(sol,1),1);
f_xy = diff(dzdx,y);
for i = 1:size(sol,1)
    B(i) = round(double(subs(f_xy,[x,y],sol(i,:))),3);  
end
disp(B);
%% Compute C
C = zeros(size(sol,1),1);
f_yy = diff(dzdy,y);
for i = 1:size(sol,1)
    C(i) = round(double(subs(f_yy,[x,y],sol(i,:))),3);  
end
disp(C);
%% Compute Hessian
D = round(B.^2 - A.*C,6)