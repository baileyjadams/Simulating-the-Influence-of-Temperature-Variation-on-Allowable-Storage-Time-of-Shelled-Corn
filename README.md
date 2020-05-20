## _Introduction_

This repository serves as a storage location for a MATLAB function that supports the following research paper: **"Simulating the Influence of Temperature Variation on Allowable Storage Time of Shelled Corn"**.  This function is labeled "Dynamic_AST_Calculator.m", and it adds a level of automation to simulating dynamic allowable storage time (AST) and visualizing dynamic AST data through plots.  This function is intended to be relatively straightforward and user-friendly.


## _How to use the Dynamic_AST_Calculator.m Function_

In order to utilize this function, only three inputs must be sequentially specified by the user from an automatically generated input box: bin fill date, minimum or maximum temperature trend, and moisture content (% wet basis). 
 
   - Bin fill date can be any date throughout the year
   - Temperature trend can be entered as either 'Min' or 'Max'
   - Moisture content needs to be specified as a numeric variable and can be any reasonable shelled corn moisture content (% wet basis)

These inputs need to be correctly formatted in order for the function to run without errors.

An example of the proper format is depicted in the default values of the input box example shown below:

![image](Example_Outputs_of_Dynamic_AST_Function/Input_Box_Example.PNG "Command Line Example")

If the specified temperature trend and moisture content inputs are valid, then acceptance messages will automatically display at the command line as the function is simulating the dynamic AST response.


## _Outputs of Function_

Each time this function is executed, it outputs a summary excel file of important dynamic AST data to the local file directory.  This summary excel file will have a corresponding timestamp associated with it in the file name.  This function also outputs two separate figures.  The first figure depicts the cumulative summation of percent AST spent, whereas the second figure depicts the days remaining of dynamic AST.

**Figure 1 Example Output**

![image](Example_Outputs_of_Dynamic_AST_Function/Figure_1_Example_Output.PNG "Figure 1 Example Output")

**Figure 2 Example Output**

![image](Example_Outputs_of_Dynamic_AST_Function/Figure_2_Example_Output.PNG "Figure 2 Example Output")

**Excel File Example Output**

![image](Example_Outputs_of_Dynamic_AST_Function/Visual_Example_of_Excel_File_Output.PNG "Visual Example of Excel File Output")


## _Conclusion_

This function helps understand how dynamic AST is altered through three inputs: bin fill date, minimum or maximum temperature trend, and moisture content (% wet basis).  By experimenting with these variables, any user can simulate different scenarios and analyze how each input transforms the dynamic AST response.
