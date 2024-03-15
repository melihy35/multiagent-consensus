clc;
close all;
clear;

time = 0:.1:20; 
%% initialize velocity, position and heading
V=10; % velocity
InitHeadings=rand(6,1)*2*pi; % initialize random heading for 6 nodes

Xpositions=zeros(6,1);% x position for 6 nodes,it will contains all positions
Ypositions=zeros(6,1);% y position for 6 nodes,it will contains all positions

IC =[InitHeadings Xpositions Ypositions];