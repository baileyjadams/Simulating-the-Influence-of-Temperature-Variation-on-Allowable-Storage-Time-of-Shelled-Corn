function Dynamic_AST_Calculator

%THIS FUNCTION REQUIRES THREE INPUTS TO BE SPECIFIED IN AN AUTOMATICALLY
%GENERATED INPUT TEXT BOX:
    % BIN FILL DATE, TEMPERATURE TREND (MIN OR MAX), & MOISTURE CONTENT (%
    % WET BASIS)
    
%THESE INPUTS NEED TO BE CORRECTLY FORMATTED IN ORDER FOR THE FUNCTION TO
%RUN WITHOUT ERRORS.
    % AN EXAMPLE OF THE PROPER FORMAT IS SHOWN BELOW:
        % Enter bin fill date: 1-Oct-2019
        % Enter temperature trend (Min or Max): Min
        % Enter moisture content (% wet basis): 15
        
%THE BIN FILL DATE CAN BE ANY DATE THROUGHOUT THE YEAR, THE TEMPERATURE
%TREND CAN BE ENTERED AS EITHER 'MIN' OR 'MAX', AND THE MOISTURE CONTENT
%(PERCENT WET BASIS) NEEDS TO BE A NUMERICAL VALUE.

%EACH TIME THIS FUNCTION IS EXECUTED, IT OUTPUTS A SUMMARY EXCEL FILE OF
%IMPORTANT DYNAMIC AST DATA, ALONG WITH TWO SEPERATE FIGURES. THE FIRST
%FIGURE DEPICTS THE CUMULATIVE SUMMATION OF PERCENT AST SPENT. THE SECOND
%FIGURE DEPICTS HOW THE NUMBER OF SAFE STORAGE DAYS REMAINING IS ALTERED AS
%A FUNCTION OF TIME, WHICH EVENTUALLY RESULTS IN A SINGLE DYNAMIC AST
%VALUE.

close all;

%Input box setup
prompt = {'Enter bin fill date:','Enter temperature trend (Min or Max):','Enter moisture content (% wet basis):'};
dlgtitle = 'Input Conditions';
dims = [1 50];  % dimensions of the input box
defaultinput = {'1-Oct-2019','Min','15'};   % specifying default input conditions
inputbox = inputdlg(prompt,dlgtitle,dims,defaultinput);

%Input conditions
start_date = datetime(inputbox(1));
temp_trend = char(inputbox(2));
moisture_content = str2double(inputbox(3)); % percent wet basis (%)

%Statements to ensure acceptable values are entered into the function
if strcmp(temp_trend,'Min') || strcmp(temp_trend,'Max')
    disp('Acceptable temperature trend input.')
else
    error('Not an acceptable temperature trend input.')
end

if le(moisture_content,0) || ge(moisture_content,100)
    error('Not an acceptable moisture content input.')
else
    disp('Acceptable moisture content input.')
end

wrap_date = dateshift(start_date,'start','year','next') - caldays(1);
d = start_date - caldays(1);

ctr = 0; loop_final_value = 30000;

for i = 1:loop_final_value
    if d == wrap_date
        d = d - calyears(1);
    end
    d = d + caldays(1);
    
    date(i,1) = d;
    dn(i,1) = day(date(i,1),'dayofyear');
    
    total_day_index(1,1) = dn(1,1)/dn(1,1);
    total_day_index(i,1) = total_day_index(1,1) + ctr;
    ctr = ctr + 1;

    if strcmp(temp_trend,'Min')
        temp_data(i,1) = 62.5458*exp(-(dn(i)-183.1313)^2/(2*92.69693^2));
    elseif strcmp(temp_trend,'Max')
        temp_data(i,1) = 83.90768*exp(-(dn(i)-183.2692)^2/(2*116.4615^2));
    end
    temp_data(i,1) = (5/9)*(temp_data(i,1)-32);
    
    instantaneous_AST(i,1) = exp(2.64661 - (0.14096*temp_data(i)) + (1183.71996/(moisture_content.^2)));
    
    moisture_content_data(i,1) = moisture_content;
    days_spent(i,1) = ones; percent_spent(i,1) = zeros;
    percent_spent_sum(i,1) = zeros;
    days_remaining(i,1) = instantaneous_AST(1,1);
end

days_spent(1,1) = 0;

for j = 2:loop_final_value
    percent_spent(j,1) = days_spent(j,1)/instantaneous_AST(j-1,1);
end

percent_spent_sum = cumsum(percent_spent);

for k = 2:loop_final_value
    days_remaining(k,1) = (1-percent_spent_sum(k,1))*instantaneous_AST(k,1);
end

%Masking data arrays to end when dynamic AST is completely spent 
days_remaining_mask = days_remaining > 0;
Day_Number = dn(days_remaining_mask);
Total_Num_Days = total_day_index(days_remaining_mask);
Temperature_Deg_C = temp_data(days_remaining_mask);
Moisture_Content_WB = moisture_content_data(days_remaining_mask);
Instantaneous_AST = instantaneous_AST(days_remaining_mask);
Days_Spent = days_spent(days_remaining_mask);
Percent_AST_Spent = percent_spent(days_remaining_mask)*100;
Cumulative_Summation_Percent_AST_Spent = percent_spent_sum(days_remaining_mask)*100;
Days_Remaining = days_remaining(days_remaining_mask);

%Write a table and then output that table to an excel file with a
%corresponding timestap at which this function was executed
Output_Table = table(Day_Number,Total_Num_Days,Temperature_Deg_C,Moisture_Content_WB,...
    Instantaneous_AST,Days_Spent,Percent_AST_Spent,Cumulative_Summation_Percent_AST_Spent,...
    Days_Remaining);
timestamp = datestr(now,'yyyymmddTHHMMSS');
FileName = sprintf('Dynamic_AST_Summary_Table_%s.xlsx',timestamp);
writetable(Output_Table,FileName,'Sheet',1,'Range','A1');

dynamic_AST = Total_Num_Days(end);
txt1 = ['Dynamic AST = ' num2str(dynamic_AST) ' days'];

static_AST = floor(instantaneous_AST(1));
txt2 = ['Static AST = ' num2str(static_AST) ' days'];

%Plot generation
figure(1)
h1 = plot(Total_Num_Days,Cumulative_Summation_Percent_AST_Spent,'linewidth',1.5);
xlim([0 Total_Num_Days(end)*1.15]); ylim([0 120]); grid on;
ax1 = ancestor(h1, 'axes'); ax1.YAxis.Exponent = 0;
vert1 = xline(dynamic_AST,'-k',txt1);
vert1.LabelHorizontalAlignment = 'right'; vert1.LabelVerticalAlignment = 'middle';
horz1 = yline(100,'-','100% AST Spent'); horz1.LabelHorizontalAlignment = 'left';
title('Cumulative Summation of Percent AST Spent');
xlabel('Time (days)'); ylabel('Cumulative Summation of Percent AST Spent (%)');

figure(2)
h2 = plot(Total_Num_Days,Days_Remaining,'linewidth',1.5);
ylim([0 max(Days_Remaining)*1.15]); grid on;
ax2 = ancestor(h2, 'axes'); ax2.YAxis.Exponent = 0;
vert2 = xline(dynamic_AST,'-k',txt1);
vert3 = xline(static_AST,'--k',txt2); vert3.LabelHorizontalAlignment = 'left';
title(['Fill Date = ' datestr(start_date) ', Temp. Trend = ' temp_trend ', M.C. = ' num2str(moisture_content) ' %'])
xlabel('Time (days)'); ylabel('Number of Safe Storage Days Remaining (days)');

end

