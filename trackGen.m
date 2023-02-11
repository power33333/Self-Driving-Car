clear all
clc

% Load the track data
track = gpxread('Road.gpx');

longit = track.Longitude';
lat = track.Latitude';

% Get the peaks of the track
minInd = find(islocalmin(longit));
maxInd = find(islocalmax(longit));
changeInd = sort([1;minInd;maxInd;length(longit)]);

% Pre-allocated variable to store the road functions
roadFuncs = cell(length(changeInd)-1,1);

% Create functions 
for i=2:length(changeInd)
    roadFuncs{i-1} = @(x) interp1(longit(changeInd(i-1):changeInd(i)), ...
        lat(changeInd(i-1):changeInd(i)),x, 'pchip');
end

% Comparison Plots with actual track
webmap('Open Street Map')
wmline(track,'OverlayName','Track Logs','Color','red');
for i=2:length(changeInd)
    precision = min(longit(changeInd(i-1)+1:changeInd(i))-longit(changeInd(i-1):changeInd(i)-1));
    x = longit(changeInd(i-1)):precision/1000:longit(changeInd(i));
%     plot(x,roadFuncs{i-1}(x),'k');
    wmline(roadFuncs{i-1}(x),x,'Color','green');
%     hold on;
end
% hold on;
% plot(longit,lat,'ro')