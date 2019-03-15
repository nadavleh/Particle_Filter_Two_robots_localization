function [  ] = plot_observations( pos, scan_cell )

    L=50; %number of scans used from the available 1080
  
    ranges = scan_cell.Ranges; %convert the 1080 range reading to a vector
    angle_increment = scan_cell.AngleIncrement; %retrieve the angle incriment
    scan_number=length(ranges); % the number of scans ( should be 1080)
    idx=randsample(scan_number,L); %sample L random indexes (uniformly) from the 1080 (or scan_number) available

    reading_position = zeros(L,2); % the reading of the L range scans that we sampled (we sampled their corresponding index)

    for k=1:L
        % aor = angle of reading. angle_increment*(535.5-idx(k)) [rad]
        % calculates angle of rading numbered: idx(k), from the horizon, 
        % to that, we need to add the partical's heading.
        % index 535.5 in "ranges" corresponds to the heading 0 [rad] from
        % the horizon, becaue the eading range is -2.3562 to 2.3562 [rad] 
        % and so -2.3562+angle_increment*535.5 = 0
        aor=mod(pos(3)+angle_increment*(535.5-idx(k)),2*pi); 
%         aor=angle_increment*(535.5-idx(k)); 


        reading_position(k,:)= [pos(1), pos(2)] + ranges(idx(k))*[ cos(aor) sin(aor)];
    end 

    scatter(reading_position(:,1),reading_position(:,2),'*k')

%         scatter(reading_position,'*k')

end



















