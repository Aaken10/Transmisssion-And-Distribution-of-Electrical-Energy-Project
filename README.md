# Transmisssion-And-Distribution-of-Electrical-Energy-Project
Develop a software program using any programming language of your choice for performing the task given below.  
Consider a three phase single circuit transmission system made of bundled conductors in all the three phases. The sub-conductors of the bundle are stranded ACSR conductors.
Develop  an  interactive  user  interface  to  collect  the  following  parameters  of  the transmission system from the user:
1. Type of the system - Symmetrical or Unsymmetrical Spacing (transposed) 
2. Spacing between the phase conductors 
3. Number of sub-conductors per bundle 
4. Spacing between the sub-conductors 
5. Number of strands in each sub conductor 
6. Diameter of each strand 
7. Length of the line in km 
8. Model of the line (Short/nominal pi/long) 
9. Resistance of the line per km 
10. Power Frequency 
11. Nominal System Voltage  
12. Receiving end load in MW. 
13. Power factor of the receiving end load.

Output Results:  
1. Inductance per phase per km in H/km 
2. Capacitance per phase per km in F/km.  
3. Inductive reactance of the line in Ohm. 
4. Capacitive reactance of the line in Ohm. 
5. Charging current drawn from the sending end substation 
6. Calculate ABCD parameters of the line. 
7. Calculate the sending end voltage in kV, if the receiving end voltage is maintained at nominal system voltage. 
8. Calculate the sending end current in A. 
9. Calculate the percentage voltage regulation. 
10. Calculate the power loss in the line in MW. 
11. Calculate the transmission efficiency. 
12. Draw the sending end circle diagram. 
13. Draw the receiving end circle diagram. 
14. Comment on the compensation requirement at the receiving end to maintain the voltage at nominal value. (Only for short line model) 
15. Compute the amount of compensation required in MVar. (Only for short line model) 

The program is written in MATLAB R2021a.

Sample input file uploaded and the calculated paramaters to that particular overhead cable will be displayed in the output file. Check power_circles.png for short line model graph and power_circles(three_models).png for comparison with all three line models.
