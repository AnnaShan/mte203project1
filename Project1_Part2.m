% Part 2
%% a. Temperatures at highest and lowest elevation
T_high = temperature(-2.300,0.687,terrain(-2.300,0.687))
T_low = temperature(2.066,1.893,terrain(2.066,1.893))
%% b. 
% i. Temperature at point
x_p = 2.2;
y_p = 0.5;
T_p = temperature(x_p,y_p,terrain(x_p,y_p))
% ii. Isotherms
z_p = terrain(x_p,y_p)
[x,y] = meshgrid(-5:0.1:5,-2:0.1:4);
[c,h] = contour(x,y,temperatureMatrix(x,y,z_p),20);
% Add labels
title('Isotherms at z = 1.1124 km');
xlabel('X');
ylabel('Y');
clabel(c,h);
% Save plot
saveas(gcf,'Isotherms.png')
%% c.
% i. Partial differentiation wrt north direction
syms x y z
dfdx = diff(terrain(x,y),x);
dfdy = diff(terrain(x,y),y);
% Calculate gradient in (0,1) direction
dir = [0,1];
dir = dir/norm(dir);
g_x = double(subs(dfdx,[x,y],[x_p,y_p]));
g_y = double(subs(dfdy,[x,y],[x_p,y_p]));
g_north = dot([g_x,g_y],dir)
% i. Calculate gradient of temperature
dir = [0,1,g_north];
dir = dir/norm(dir);
% Compute gradient vector at current location
g = gradient(temperature(x,y,z), [x y z]);
% Compute rate of change in temperature in specified direction
dT = double(dot(subs(g,[x,y,z],[x_p,y_p,z_p]),dir))
%% d.
% i. Partial differentiation wrt southwest direction
% Calculate gradient in (0,1) direction
dir = [-1,-1];
dir = dir/norm(dir);
g_southwest = dot([g_x,g_y],dir)
% i. Calculate gradient of temperature
dir = [-1,-1,g_southwest];
dir = dir/norm(dir);
% Compute gradient vector at current location
g = gradient(temperature(x,y,z), [x y z]);
% Compute rate of change in temperature in specified direction
dT = double(dot(subs(g,[x,y,z],[x_p,y_p,z_p]),dir))
%% e. Surface plot of terrain
% Define and plot terrain function
[x,y] = meshgrid(-5:0.1:5,-2:0.1:4);
z = terrainMatrix(x,y);
s = surf(x,y,z);
% Add labels
title('Surface Plot of Terrain with Mapped Temperature');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on;
% Define colormap function
s.CData = temperatureMatrix(x,y,terrainMatrix(x,y));
colorbar;
% Save plot
saveas(gcf,'SurfaceColor.png');
%% f. Temperature plot
% Define function
z = terrainMatrix(x,y);
surf(x,y,temperatureMatrix(x,y,z))
% Add labels
title('Surface Plot of Temperature');
xlabel('X');
ylabel('Y');
zlabel('T');
% Save plot
saveas(gcf,'Temp.png')
%% Lagrange multipliers
syms x y z
% Decrease fsolve function tolerance
options = optimoptions('fsolve','TolFun',1E-12);
% Set initial guess to be somewhere around the highest elevation point
sol = fsolve(@lagrange,[-2.3, 0.6, 3.7, 0],options)
T = temperature(sol(1),sol(2),sol(3))