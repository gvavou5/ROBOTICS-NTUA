function [] = plot_maker( x_axe,y_axe,z_axe,der_t,q1,var2,var3)
    figure();
    subplot(3,1,1); 
    plot(x_axe(:),'g'); 
    xlabel('Time(sec)'); 
    ylabel('X(m)');
    subplot(3,1,2); 
    plot(y_axe(:),'g');
    xlabel('Time(sec)');
    ylabel('Y(m)');
    subplot(3,1,3); 
    plot(z_axe(:),'g'); 
    xlabel('Time(sec)');
    ylabel('Z(m)');
    figure();
    subplot(3,1,1);
    plot(q1,'r');
    xlabel('Time(sec)'); 
    ylabel('J1(rad)');
    subplot(3,1,2);
    plot(var2,'r'); 
    xlabel('Time(sec)');
    ylabel('J2(rad)');
    subplot(3,1,3); 
    plot(var3,'r'); 
    xlabel('Time(sec)');
    ylabel('J3(rad)');
    figure();
    subplot(3,1,1); 
    plot(diff(x_axe)/der_t, 'y');
    xlabel('Time(sec)');
    ylabel('VX(m/sec)');   %grammikh taxuthta
    subplot(3,1,2); 
    plot(diff(y_axe)/der_t,'y');
    xlabel('Time(sec)'); 
    ylabel('VY(m/sec)');
    subplot(3,1,3); 
    plot(diff(z_axe)/der_t,'y');
    xlabel('Time(sec)'); 
    ylabel('VZ(m/sec)');
    figure();
    subplot(3,1,1);
    plot(diff(q1)/der_t);
    xlabel('Time(sec)'); 
    ylabel('CV1(rad/sec)'); % gwniakh taxuthta
    subplot(3,1,2); 
    plot(diff(var2)/der_t);
    xlabel('Time(sec)'); 
    ylabel('CV2(rad/sec)');
    subplot(3,1,3);
    plot(diff(var3)/der_t);
    xlabel('Time(sec)'); 
    ylabel('CV3(rad/sec)');
    
    x1 = diff(q1)/der_t;
    x2 = diff(var2)/der_t;
    x3 = diff(var3)/der_t;

    for i= 1:size(x1,2)
        cv1(i) = sin(q1(i))*x2(i) - cos(q1(i))*sin(var2(i))*x3(i);
        cv2(i) = -cos(q1(i))*x2(i) - sin(q1(i))*sin(var2(i))*x3(i);
        cv3(i) = x1(i) + cos(var2(i))*x3(i);
    end 
    
    figure();
    subplot(3,1,1); 
    plot(cv1(:),'c'); 
    xlabel('Time(sec)'); 
    ylabel('CVX(rad/sec)');
    subplot(3,1,2); 
    plot(cv2(:),'c');
    xlabel('Time(sec)');
    ylabel('CVY(rad/sec)');
    subplot(3,1,3); 
    plot(cv3(:),'c'); 
    xlabel('Time(sec)');
    ylabel('CVZ(rad/sec)');
    
end

