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

%% Adjacency matrix 
A= [0 0 1 0 0 0;
    1 0 0 0 0 1;
    1 1 0 0 0 0;
    0 1 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 1 1 0]; 

L=Laplacian(A); % graph Laplacian matrix


%% update all iterations continuously

[t,states] = ode23(@(t, states) updatefunc(t,states,V,L), time, IC);

AllHeadings =states(:,1:6)';
AllXpositions =states(:,7:12)';
AllYpositions =states(:,13:18)';


%% heading plot
figure;
hold on;

for i = 1:size(AllHeadings, 1)
    plot(AllHeadings(i, :));
end

title("Heading angles for all nodes")
xlabel("Time")
ylabel("heading angle")

%% position plot 
figure;
hold on;

for i = 1:size(AllXpositions, 1)
    plot(AllXpositions(i,  :),AllYpositions(i , :));
end

title("Positions for all nodes")
xlabel("x position")
ylabel("y position")

%% functions
function [L] = Laplacian(matrix)   
    D=zeros(6); %initialize of in-degree matrix
    for i = 1:6
        D(i,i) =sum(matrix(i,:)); % find in-degree matrix
    end 
    L= D-matrix; % return graph Laplacian matrix
end

function NewStates = updatefunc(t,states,V,L)

    newTheta =-L*states(1:6);
    newX = V*sin(states(1:6));
    newY = V*cos(states(1:6));
    NewStates = [newTheta;newX;newY];
end
