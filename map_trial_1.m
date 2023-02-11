%% 
% clc;clear all;close all

trk1 = gpxread('Road.gpx');
trk2 = gpxread('Road.gpx','Index',1);

lat = {trk1.Latitude, trk2.Latitude};
lon = {trk1.Longitude, trk2.Longitude};
elevation = {trk1.Elevation, trk2.Elevation};

tracks = geoshape(lat,lon,'Elevation',elevation);

webmap('Open Street Map')
colors = {'cyan','red'};
wmline(tracks, 'Color', colors)

[latlim, lonlim] = geoquadline(tracks(1).Latitude,tracks(1).Longitude);
wmlimits(latlim,lonlim)
%% 
wpt = gpxread('Road.gpx');
trk = gpxread('Road.gpx','FeatureType','track');
webmap('worldimagery')
wmline(trk,'OverlayName','Track Logs','Color','red');