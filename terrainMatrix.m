function F = terrainMatrix(x,y)
    F = log(x.^4+1).*(4*x.^4+(2*y).^2) ...
        .*exp(-0.5*x.^2-(y-0.8).^2-3) ...
        .*(sin(2*x+0.05*y.^4)+2*cos(0.75*y));
end