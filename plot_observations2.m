function [  ] = plot_observations2( pos, scan_cell )
  
    ranges = scan_cell.Ranges; %convert the 1080 range reading to a vector
    angle_increment = scan_cell.AngleIncrement; %retrieve the angle incriment
    scan_number=length(ranges); % the number of scans ( should be 1080)

    reading_position = zeros(scan_number,2); % the reading of the L range scans that we sampled (we sampled their corresponding index)

    for k=1:scan_number
        aor(k)=pos(3)-angle_increment*(535.5-k); 

        reading_position(k,:)= [pos(1), pos(2)] + ranges(k)*[ cos(aor(k)) sin(aor(k))];
    end 

    scatter(reading_position(:,1),reading_position(:,2),'*k')


end



















