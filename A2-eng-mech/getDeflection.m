function getDeflection( myfile )
% Last edited by Chong Shen Ng 14/4/2016
% Note: Make sure this code is in the same folder as your images

set(0,'DefaultAxesFontsize',18,'DefaultTextFontSize',18,'DefaultTextInterpreter','latex')
close all; 

if(nargin < 1)
    myfile  = input('   Enter input_filename (without quotes) : ', 's');
    myimg   = imread(myfile);
else
    myimg   = imread(myfile);
end

% Load the image
fig = image(myimg); hold on;
input('   Enlarge your image and press ENTER to continue ...');

% Set up the calibration
fprintf('\n   ## Now for calibration (note: you can  press BACKSPACE or DELETE to remove selected point) ##\n');
disp('   Click the top-left and bottom-right of a rectangle on the calibration paper and press ENTER to continue ...'); 

[x_calib,y_calib] = getpts();
h3 = plot3([x_calib(1) x_calib(2) x_calib(2) x_calib(1) x_calib(1)], ...
           [y_calib(1) y_calib(1) y_calib(2) y_calib(2) y_calib(1)], [0 0 0 0 0], 'xr-');
phys_X = input('   Enter the horizontal distance of the rectangle in mm:  ');
phys_Y = input('   Enter the vertical distance of the rectangle in mm:  ');
delete(h3);

% This is the approximate distortion factor at 300mm from the beam
distort_factor = 1.04;

% Now extract the deflection of the beam in segments
fprintf('\n   ## Now extract the profile of the beam ##\n');
disp('   Starting from the left, click on small segments of the beam and press ENTER when done ...');
[x,y] = getpts();
x_p=x.*phys_X/(x_calib(2)-x_calib(1));
y_p=y.*phys_Y/(y_calib(1)-y_calib(2));

X = (x_p - min(x_p))./distort_factor;
Y = y_p - y_p(1);

% Now write X and Y to a .txt file using myfile as the name
[~,fname,~] = fileparts([pwd '/' myfile]);
fid = fopen(sprintf('%s.txt',fname),'w');
fprintf(fid,'%%X\tY\n');
for i = 1:length(X)
    fprintf(fid,'%f\t%f\n',[X(i) Y(i)]);
end;

fclose(fid);
fprintf('\n   ## X and Y are stored in %s.txt ##\n',fname);

figure;
plot(X, Y, 'ko-');
xlabel('$$x$$ (mm)');
ylabel('$$y$$ (mm)');

end

