%% Particle Filter implementation

%% Load Robot 1 data
% load('robot1.mat');
% dt1=cell2mat(dt1);
% omometry_data1=cell2mat(omometry_data1);
% X1=cell2mat(X1);
clearvars -except  dt1 omometry_data1 X1 scans1
clc;


%% initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%map%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
map_to_obsticale_vector;
% map_ranges is the vector [min(x) max(x) min(y) max(y)] 
map_ranges = [min(obsticle_vector(:,1)) max(obsticle_vector(:,1)) ...
              min(obsticle_vector(:,2)) max(obsticle_vector(:,2))]; 
          
xmin=map_ranges(1);  xmax=map_ranges(2); ymin=map_ranges(3);  ymax=map_ranges(4);         

   
NumOfMix = 1000;
gm=GMM_map( obsticle_vector(randsample(2629,NumOfMix),:) ,map_ranges,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% initialize particles
N = 500; % numbre of particles

       

% generate particles uniformly distributed - state is (X,Y,Theta)_t
particles1 = [xmin - (xmin-xmax)*rand(N,1), ymin - (ymin-ymax)*rand(N,1), 2*pi*rand(N,1)];

%%uncomment to show
% scatter(obsticle_vector(:,1),obsticle_vector(:,2))
% hold on
% scatter(particles(:,1),particles(:,2))

%% localize
% estimate1 = zeros(length(dt1)+1,3); 
% estimate1(1,:) = mean(particles1,1);
for k = 1:length(dt1)
    if (k==36)
        particles1(:,3) = 75*pi/180 +normrnd(0,0.1);
    end
    clf;
    scatter(obsticle_vector(:,1),obsticle_vector(:,2)); hold on;
    plot_robot(X1(k,:)+[10 10 0],0.3)
    plot_robot(estimate1,0.6)
    particles1= move_prtcls( particles1,omometry_data1(k,1), omometry_data1(k,2),dt1(k) );
    scatter(particles1(:,1),particles1(:,2),'.')
    pause(0.02)
    particles1_weight  = weigh_particles( particles1, gm, scans1{k,1} );
    % re-sample
    particles1 = particles1(randsample((1:N),N,true,particles1_weight),:);
%     clf;
%     scatter(obsticle_vector(:,1),obsticle_vector(:,2)); hold on;
%     scatter(particles1(:,1),particles1(:,2),'.')
%     pause(0.02)

    estimate1=mean(particles1,1);
%     plot_robot(estimate1,0.6)
%     plot_observations( estimate1, scans1{k,1})
    pause(0.02)

disp('time step: ')
disp(k)
    
end













