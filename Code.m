clear;
clc;

%% TnD Group Task
% Members:
% 107120001 - Aayush
% 107120003 - Abhishek
% 107120037 - Dhruva

%% Inputs
system = input('Type of the system Symmetrical(Put 1) Unsymmetrical Spacing(Put 2): ');
if system == 1
    Symmetrical_Spacing = input('Spacing between the phase conductors(m)(Symmetrical): ');                                             
else
   Phase_Distance1 = input('Spacing between the phase conductors(enter distance)(m) a(Unsymmetrical): ');
   Phase_Distance2 = input('Spacing between the phase conductors(enter distance)(m) b(Unsymmetrical): ');
   Phase_Distance3 = input('Spacing between the phase conductors(enter distance)(m) c(Unsymmetrical): ');
end
No_of_Sub_Conductors = input('Number of sub-conductors per bundle: ');
Sub_Conductor_Spacing = input('Spacing between the sub-conductors(m): ');
No_of_Strands = input('Number of strands in each sub-conductor: ');
diameter_of_strand = input('Diameter of each strand(m): ');
Length_of_Line= input('Length of line(km): ');
Transmission_Model = input('Transmission_Model of Line(1-Short , 2-Nominal Pi ,3-Long): ');
resistance = input('Resistance of line per km(Ohms): ');
Frequency = input('Power Frequency(Hz): ');
Nominal_Voltage = input('Nominal Voltage(V): ');
Receiving_End_Power = input('Receiving end load(MW): ');
power_factor = input('Power factor of receiving end load: ');


%% Computations


% Receiving end voltage is maintained at nominal system voltage
    VR = Nominal_Voltage / sqrt(3);

% Calculating Radius r 

% 3(No_of_layers)^2 - 3(No_of_layers) + 1- (No_of_strands) = 0

% p(n)^2 + qn + r = 0
    
    p = 3;
    q = -3;
    r = 1 - No_of_Strands;

% Calculating the Discriminant

    di = (q * q) - (4 * p * r);

% Finding two solutions

    sol1 = (-q - sqrt(di)) / (2 * p);
    sol2 = (-q + sqrt(di)) / (2 * p);
    
    Real_part1 = sum(real(sol1(:)));
    Real_part2 = sum(real(sol2(:)));

    if Real_part1 >= Real_part2
        n = Real_part1;
    else
        n = Real_part2;
    end

    D = (2 * n - 1) * diameter_of_strand;
    r = D / 2;
    
 % Inductance(L)
    if system == 1

        MGMD =  Symmetrical_Spacing;
        
        if No_of_Sub_Conductors == 2
            SGMD = (r * 0.7788 * Sub_Conductor_Spacing)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 3
            SGMD = (r * Sub_Conductor_Spacing^(2) * 0.7788)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 4
            SGMD = (r * Sub_Conductor_Spacing^(3) * 0.7788 * sqrt(2))^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 5
            SGMD = (r * Sub_Conductor_Spacing^(4) * 0.7788 * (1.618)^2)^(1/No_of_Sub_Conductors);
       elseif No_of_Sub_Conductors == 6
            SGMD = (r * Sub_Conductor_Spacing^(5) * 0.7788 * 6)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 7
            SGMD = (r * Sub_Conductor_Spacing^(6) * 0.7788 * 16.39)^(1/No_of_Sub_Conductors);
        else
            fprintf("\n\nValue of No_of_Sub_Conductors above 7 is not practically feasible so its value can't be %d ", No_of_Sub_Conductors);
        end
      
    else
        MGMD = (Phase_Distance1 *Phase_Distance2 *Phase_Distance3)^(1 / 3);
        if No_of_Sub_Conductors == 2
            SGMD = exp(-1 / (4*No_of_Sub_Conductors)) * (r^(1 / No_of_Sub_Conductors)) * Sub_Conductor_Spacing^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 3
            SGMD = (r * (Sub_Conductor_Spacing)^(2) * 0.7788)^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 4
            SGMD = (sqrt(2) * r * (Sub_Conductor_Spacing)^(3) * 0.7788)^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 5
            SGMD = (r * Sub_Conductor_Spacing^(4) * 0.7788 * (1.618)^2)^(1/No_of_Sub_Conductors);
       elseif No_of_Sub_Conductors == 6
            SGMD = (r * Sub_Conductor_Spacing^(5) * 0.7788 * 6)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 7
            SGMD = (r * Sub_Conductor_Spacing^(6) * 0.7788 * 16.39)^(1/No_of_Sub_Conductors);
        else
            fprintf("Value of No_of_Sub_Conductors above 7 is not practically feasible so its value can't be %d ", No_of_Sub_Conductors);
        end
        
    end
    L = 2 * 10^(-4) * log(MGMD/SGMD);
    
% Capacitance---Cap
    if Transmission_Model == 1
        Cap = 0;
    else
        if system == 1
           MGMD =  Symmetrical_Spacing;
        
        if No_of_Sub_Conductors == 2
            SGMD = (r * Sub_Conductor_Spacing)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 3
            SGMD = (r * Sub_Conductor_Spacing^(2) )^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 4
            SGMD = (r * Sub_Conductor_Spacing^(3) * sqrt(2))^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 5
            SGMD = (r * Sub_Conductor_Spacing^(4) * (1.618)^2)^(1/No_of_Sub_Conductors);
       elseif No_of_Sub_Conductors == 6
            SGMD = (r * Sub_Conductor_Spacing^(5) * 6)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 7
            SGMD = (r * Sub_Conductor_Spacing^(6) * 16.39)^(1/No_of_Sub_Conductors);
        else
            fprintf("Value of No_of_Sub_Conductors above 7 is not practically feasible so its value can't be %d ", No_of_Sub_Conductors);
        end
        else
            MGMD = (Phase_Distance1 *Phase_Distance2 *Phase_Distance3)^(1 / 3);
        if No_of_Sub_Conductors == 2
            SGMD = exp(-1 / (4*No_of_Sub_Conductors)) * (r^(1 / No_of_Sub_Conductors)) * Sub_Conductor_Spacing^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 3
            SGMD = (r * (Sub_Conductor_Spacing)^(2) * 0.7788)^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 4
            SGMD = (sqrt(2) * r * (Sub_Conductor_Spacing)^(3) * 0.7788)^(1 / No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 5
            SGMD = (r * Sub_Conductor_Spacing^(4) * 0.7788 * (1.618)^2)^(1/No_of_Sub_Conductors);
       elseif No_of_Sub_Conductors == 6
            SGMD = (r * Sub_Conductor_Spacing^(5) * 0.7788 * 6)^(1/No_of_Sub_Conductors);
        elseif No_of_Sub_Conductors == 7
            SGMD = (r * Sub_Conductor_Spacing^(6) * 0.7788 * 16.39)^(1/No_of_Sub_Conductors);
        else
            fprintf("Value of No_of_Sub_Conductors above 7 is not practically feasible so its value can't be %d ", No_of_Sub_Conductors);
        end
         Cap = 2 * pi * 8.84 * 10^(-9) / log(MGMD/SGMD);
        end
    end 
   
    
% Inductive Reactance---XL
    XL = 2 * pi * Frequency * L * Length_of_Line;

% Capacitive Reactance---XC
    if Transmission_Model == 1
        XC = "infinite";
    else
        XC = 1 / (2 * pi * Frequency * Cap * Length_of_Line);
    end

% ABCD paramters
    if Transmission_Model == 1
        Y = 0; % Admittance
    else
        Y = complex(0, 1 / XC);
    end
  
    Z = complex(resistance * Length_of_Line, XL); % Reactance

    if Transmission_Model == 1
        A = 1;
        B = Z;
        C = Y;
        D = A;
    elseif Transmission_Model == 2
        A = 1 + Y * Z / 2;
        B = Z;
        C = Y * (1 + Y * Z / 4);
        D = A;
    else
        A = cosh(sqrt(Y * Z));
        B = sqrt(Z / Y) * sinh(sqrt(Y * Z)); 
        C = sqrt(Y / Z) * sinh(sqrt(Y * Z));
        D = A;
    end

% Receving end current---IR
    IR = Receiving_End_Power * 10^6 / (power_factor * VR * 3);

% Sending end line voltage---VS
    VS = A * VR + B * IR;

% Charging current---IC
    if Transmission_Model == 1
        IC = 0;
    elseif Transmission_Model == 2
        IC1 = VS * Y / 2;
        IC2 = VR * Y / 2;
        IC = IC1 + IC2;
    else
        IC = C * VR;
    end

% Sending end line Current----IS
    IS = C * VR + D * IR;

% Voltage Regulation---Voltage_Regulation
    if Transmission_Model == 1
        Voltage_Regulation = (abs(VS) - abs(VR)) * 100 / abs(VR);
    else
        Voltage_Regulation = (abs(VS / A) - abs(VR)) * 100 / abs(VR);
    end 

% Power loss---power_loss
    IR_real = sum(real(IR(:)));
    power_loss = 3 * IR_real * IR_real * resistance * Length_of_Line;

% Transmission Efficiency---eff
    eff = Receiving_End_Power * 100 / (Receiving_End_Power + power_loss * 10^(-6));   
    
% Angles
    angle_1 = angle(A);
    angle_2 = angle(B);

%% Outputs


fprintf("\n\n\nMembers:\n");
fprintf("1. 107120001 - Aayush\n");
fprintf("2. 107120003 - Abhishek\n");
fprintf("3. 107120037 - Dhruva\n");

% 1. Inductance
    fprintf("\n L = %d H/km per phase", L);

% 2. Capacitance
    fprintf("\n C = %d F/km per phase", Cap);

% 3. Inductive reactance
    fprintf("\n XL = %d ohm", XL);

% 4. Capacitive reactance
    if Transmission_Model == 1
        fprintf("\n XC = infinite");
    else
        fprintf("\n XC = %d ohm", XC);
    end

% 5. Charging current
    fprintf("\n Ichg = %d", imag(IC));

% 6. ABCD parameters
    fprintf("\n A = D = %f +j%f", real(A), imag(A));
    fprintf("\n B = (%d + j%f) ohm", real(B), imag(B));
    fprintf("\n C = (%d + j%f) mho", real(C), imag(C));

% 7. Sending end voltage
    fprintf("\n VS = %d V", abs(VS) * sqrt(3));

% 8. Sending end current
    fprintf("\n IS = %d A", abs(IS));

% 9. Precentage voltage regulation
    fprintf("\n Percentage Voltage Regulation = %d %%", Voltage_Regulation);

% 10. Power loss
    fprintf("\n Line Loss = %d MW", power_loss/(1e6));

% 11. Transmission efficiency
    fprintf("\n Efficiency = %d %%\n", eff);
    
% 12. Sending end circle
    x = -abs(A) * abs(VS / 1000) * abs(VS / 1000) * cos(angle_2 - angle_1) / abs(B);
    y = abs(A) * abs(VS / 1000) * abs(VS / 1000) * sin(angle_2 - angle_1) / abs(B);
    rad_1 = abs(VS / 1000) * abs(VR / 1000) / abs(B);
    centre_1 = x + 1i * y;  % taking MATLAB's suggestion and writing j as 1i

    % printing center and radius
    fprintf("\n SENDING END POWER CIRCLE:");
    if imag(centre_1) >= 0
        fprintf("\n \tCenter: %d + j%d\n \tRadius: %d\n", real(centre_1), imag(centre_1), rad_1);
    else
        fprintf("\n \tCenter: %d - j%d\n \tRadius: %d\n", real(centre_1), -imag(centre_1), rad_1);
    end
    
    th = 0 : pi / 500 : 2 * pi;
    xunit = rad_1 * cos(th) + x;
    yunit = rad_1 * sin(th) + y;
    subplot 121;
    hold on;
    plot(xunit, yunit, 'blue');
    plot(x, y, 'x');
    grid on;
    axis square;
    title('Sending End Circle');
    ylabel('Apparent Power');
    xlabel('Real Power');

% 13. Receving end circle
    x1 = -abs(A) * abs(VR / 1000) * abs(VR / 1000) * cos(angle_2 - angle_1) / abs(B);
    y1 = -abs(A) * abs(VR / 1000) * abs(VR / 1000) * sin(angle_2 - angle_1) / abs(B);
    rad_2 = abs(VS/1000) * abs(VR/1000) / abs(B);
    centre_2 = x1 + 1i * y1;    % taking MATLAB's suggestion and writing j as 1i

    % printing center and radius
    fprintf("\n RECEIVING END POWER CIRCLE:");
    if imag(centre_2) >= 0
        fprintf("\n \tCenter: %d + j%d\n \tRadius: %d\n", real(centre_2), imag(centre_2), rad_2);
    else
        fprintf("\n \tCenter: %d - j%d\n \tRadius: %d\n", real(centre_2), -imag(centre_2), rad_2);
    end

    th1 = 0 : pi / 500 : 2 * pi;
    xunit = rad_2 * cos(th1) + x1;
    yunit = rad_2 * sin(th1) + y1;
    
    subplot 122;
    hold on;
    plot(xunit, yunit, 'blue');
    plot(x1, y1, 'x');
    grid on;
    axis square;
    title('Receiving End Circle');
    ylabel('Apparent Power');
    xlabel('Real Power');

% This segment will run only if we chose short transmission line Transmission_Model
if Transmission_Model == 1
    ang = acos(-x1 / rad_2);    % finding y-intercept by setting xunit = 0
    compensation = rad_2 * sin(ang) + y1;   % substituting the value obtained in yunit
    % 14. Comment on compensation required at receiving end
        if(compensation > 0)
            fprintf("We require shunt capacitive compensation so that the reactive power is decreased to maintain the load at nominal condition");
        else
            fprintf("We require shunt inductive compensation so that the reactive power is increased to maintain the load at nominal condition");
        end

    % 15. Compensation required in MVar
        fprintf("\n Compensation = %d MVar\n", abs(compensation));
end