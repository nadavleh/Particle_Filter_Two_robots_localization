function [ weights ] = weigh_particles( particles, gm, scan_cell )

    % initialization
    L=100; %number of scans used from the available 1080
    [N,~]=size(particles); %number of particals
    ranges = scan_cell.Ranges; %convert the 1080 range reading to a vector
    angle_increment = scan_cell.AngleIncrement; %retrieve the angle incriment
    scan_number=length(ranges); % the number of scans ( should be 1080)
    idx=randsample(scan_number,L); %sample L random indexes (uniformly) from the 1080 (or scan_number) available
    % ranges_small=ranges(idx);

    % weight each partical
    weights = zeros(N,1); % scalar weight for each particl
    reading_position = zeros(L,2); % the reading of the L range scans that we sampled (we sampled their corresponding index)

    for i=1:N


        for k=1:length(idx)
            % aor = angle of reading. angle_increment*(535.5-idx(k)) [rad]
            % calculates angle of rading numbered: idx(k), from the horizon, 
            % to that, we need to add the partical's heading.
            % index 535.5 in "ranges" corresponds to the heading 0 [rad] from
            % the horizon, becaue the eading range is -2.3562 to 2.3562 [rad] 
            % and so -2.3562+angle_increment*535.5 = 0
            aor=particles(i,3)+angle_increment*(535.5-idx(k)); 

            reading_position(k,:)= [particles(i,1), particles(i,2)] + ranges(idx(k))*[ cos(aor) sin(aor)];
        end 

        vor = pdf(gm, reading_position)+eps;% values of reading - evaluated on the maps gmm
                                        % now we actually need to multiply all
                                        % this vector's component but instead
                                        % we will sum theire log values (almost
                                        % equivillant).

        weights(i) = prod((vor));
    end
    
    % maybe make it greater than zero
%      weights = weights+abs(min(weights));
    % maybe normalize
     weights = weights/sum( weights );
end









