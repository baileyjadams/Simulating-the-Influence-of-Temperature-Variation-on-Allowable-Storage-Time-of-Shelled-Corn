## _Introduction_

This repository serves as a storage location for a MATLAB function that supports the following research paper: **"Simulating the Influence of Temperature Variation on Allowable Storage Time of Shelled Corn"**.  This function is labeled "Dynamic_AST_Calculator.m", and it adds a level of automation to simulating dynamic allowable storage time (AST) and visualizing data.  This function is intended to be relatively straightforward and user-friendly.

## _How to use the Dynamic_AST_Calculator.m Function_

In order to utilize this function, only three inputs must be sequentially specified by the user: bin fill date, minimum or maximum temperature trend, and moisture content (% wet basis).  These three inputs are expressed as "Input_Date", "Input_Temp_Trend", and "Input_Moisture_Content" variables in the first line of the function.  
 
   - "Input_Date" needs to be specified as string variable and can be any date throughout the year
   - "Input_Temp_Trend needs to be specified as a string varible in the form of 'Min' or 'Max'
   - "Input_Moisture_Content" needs to be specified as a numeric variable and can be any reasonable moisture content (% wet basis)

An example of how to use this function at the command line is shown below:

![image](Example_Outputs_of_Dynamic_AST_Function/Command_Line_Example.PNG "Command Line Example")

If the specified temperature trend and moisture content inputs are valid, then acceptance messages will automatically display as the function is simulating the dynamic AST response.

## _Outputs of Function_

![image](Example_Outputs_of_Dynamic_AST_Function/Figure_1_Example_Output.PNG "Figure 1 Example Output")

![image](Example_Outputs_of_Dynamic_AST_Function/Figure_2_Example_Output.PNG "Figure 2 Example Output")

