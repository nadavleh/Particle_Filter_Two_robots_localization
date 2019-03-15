particle=[1.286767810032609+10,-5.088027415863102+10,1.999439189241661];

for k = 1:length(dt1)
    clf;
    scatter(obsticle_vector(:,1),obsticle_vector(:,2)); hold on;
    scatter(particle(1),particle(2),'.')
    pause(0.02)
    particle= move_prtcls( particle,omometry_data1(k,1), omometry_data1(k,2),dt1(k) );
    scatter(particle(1),particle(2),'.')
    pause(0.02)

end
