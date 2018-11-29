function F = temperatureMatrix(x,y,z)
    F = -2*z.^2+10 ...
    -exp(-0.1*((-0.1*x-2)-(0.05*y-3).^2-(z-1).^2));
end