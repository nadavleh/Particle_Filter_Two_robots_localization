function [ prticle_array ] = move_prtcls( prticle_array,v,w,dt )
    
    prticle_array=prticle_array';
    [~, N]=size(prticle_array);
    
    std_v = 0.8;
    std_w = 0.8;
    for i=1:N
%       prticle_array(3,i)=prticle_array(3,i)+w*dt; %Theta
      prticle_array(1,i)=prticle_array(1,i)+(v+normrnd(0,std_v))*dt*cos(prticle_array(3,i));  %X
      prticle_array(2,i)=prticle_array(2,i)+(v+normrnd(0,std_v))*dt*sin(prticle_array(3,i));  %Y
      prticle_array(3,i)=prticle_array(3,i)+(w+normrnd(0,std_w))*dt; %Theta
    end 
    prticle_array=prticle_array';
end

