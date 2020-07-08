function extractLengths( myfile )
% Use to extract physical distance between two points in an image.
% image is specified by input MYFILE
% example function call ....
%
% >> extractLengths('image.jpg')
%
% First pick two points with known separation in mm for caliberation
% Use this caliberation to measure distance between two other points in the
% same plane.

%% Created by Bharat Sundaram on 15/2/2016
%% last edited by Bharat Sundaram on 24/02/2016
% last edited by CS on 02/03/2016

set(0,'DefaultAxesFontsize',18,'DefaultTextFontSize',18)
close all
% clc

if(nargin < 1)
    myfile  = input('   Enter input_filename (without quotes) : ', 's');
    myimg   = imread(myfile);
else
    myimg   = imread(myfile);
end

fig = image(myimg);
c = input('   Enlarge your image and press ENTER to continue ...'); % so the user can zoom the fig window
fprintf(1,'   Choose two points on your image with known separation ...\n');
[xcal, ycal]    = ginput(2);
A_hist          = [xcal(1) ycal(1)];
B_hist          = [xcal(2) ycal(2)];
dist_orig       = input('   Enter the distance between the two points in mm : ');

% calibration factor
scale = dist_orig / sqrt(sum((A_hist - B_hist).^2));
hold on;
hred = plot(xcal, ycal, 'x-r');

% fprintf(1,'Choose two points on image whose separation you want to find...\n');
fprintf(1,'   Pick a point whose physical location is required ... \n');
[xcal, ycal]    = ginput(1);
A_new           = [xcal ycal];
dist_new        = sqrt(sum((A_new - B_hist).^2)) * scale;

plot([A_new(1) B_hist(1)], [A_new(2) B_hist(2)] ,'x-b');
text(mean([A_new(1) B_hist(1)]), mean([A_new(2) B_hist(2)]), ...
        sprintf('%6.3f mm',dist_new),'color','blue',...
        'HorizontalAlignment','center',...
        'BackgroundColor','w');
    
fprintf(1,'   Your required distance measurement is %6.3f mm\n', dist_new);

dist_remain     = sqrt(sum((A_new - A_hist).^2)) * scale;
delete(hred);
plot([A_new(1) A_hist(1)], [A_new(2) A_hist(2)], 'x-r');
text(mean([A_new(1) A_hist(1)]), mean([A_new(2) A_hist(2)]), ...
        sprintf('%6.3f mm',dist_remain),'color','red',...
        'HorizontalAlignment','center',...
        'BackgroundColor','w');


end

