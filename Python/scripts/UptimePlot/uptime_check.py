               
                ##########################################################
                ####                                                  ####
                ####        YEAR UPTIME PLOT & MONTHLY AVERAGE        ####
                ####                                                  ####
                ##########################################################



#### Lib import & files declaration
import matplotlib.pyplot as plt
import pandas as pd
import csv
import datetime


csv_file_path = '/home/federico/Nextcloud/Python/scripts/UptimePlot/uptime.csv'

#### Year to visualize the plot
selected_year = datetime.date.today().year

#### Output path
plot_output = "/home/federico/Nextcloud/Python/scripts/UptimePlot"
monthly_avg_txt_output = f'/home/federico/Nextcloud/Python/scripts/UptimePlot/{selected_year}_monthly_uptime_avg.txt'



df = pd.read_csv(csv_file_path, delimiter=";")




################################################################################################################
################################################################################################################
################################################################################################################


#### Convert DATE column to datetime object
df['DATE'] = pd.to_datetime(df['DATE'])

#### Convert a time string (e.g. "3:15") to total minutes
def time_to_minutes(time_str):
    
    try:
        hours, minutes = time_str.strip().split(':')
        return int(hours) * 60 + int(minutes)
    
    #### If the uptime is >1, remove the "min" part
    except ValueError as e:
        if "min" in time_str:
            minutes = time_str.replace('min','').strip()
            return int(minutes)
        if "day" in time_str:
            hours = 24
            return int(hours)

#### Convert the TIME column to uptime in minutes
df['Uptime_minutes'] = df['TIME'].apply(time_to_minutes)



################################################################################################################
################################################################################################################
################################################################################################################


####                                 Weekly uptime in the selected year

#### Filter the dataframe for the selected year
df_year = df[df['DATE'].dt.year == selected_year]

#### Group the data by week (using Monday as the start of the week)
df_year['Week'] = df_year['DATE'].dt.to_period('W-MON')

#### Calculate the sum of uptime for each week
weekly_uptime = df_year.groupby('Week')['Uptime_minutes'].sum().reset_index()

#### Create the x-axis labels as week ranges
x_labels = [f"Week {i+1}: {week.start_time.strftime('%b %d')} - {week.end_time.strftime('%b %d')}" for i, week in enumerate(weekly_uptime['Week'])]

#### Plot the data
plt.figure(figsize=(24, 12))
plt.plot(x_labels, weekly_uptime['Uptime_minutes'], linestyle='-')


#### Title and labels
plt.title(f'Uptime Over Time in {selected_year}')
plt.xlabel('Week')
plt.ylabel('Uptime in Minutes (1440m = 24h)')


#### Rotate x-axis labels for readability
plt.xticks(rotation=90)
plt.tight_layout()


plt.savefig(f"{plot_output}/{selected_year}_weekly_uptime_plot.png", dpi=300)
#plt.show()



################################################################################################################
################################################################################################################
################################################################################################################


####                                Average Uptime Per Month

#### Group by month and calculate the mean
monthly_avg = df.groupby(df['DATE'].dt.month)['Uptime_minutes'].mean()


#plt.figure(figsize=(10, 4))
plt.figure(figsize=(16, 8))


plt.bar(monthly_avg.index, monthly_avg.values, color='skyblue')
plt.title('Average Uptime per Month')
plt.xlabel('Month')
plt.ylabel('Average Uptime (720m = 12h)')


#### Convert the month from numbers to names 
plt.xticks(monthly_avg.index, [pd.to_datetime(str(m), format='%m').strftime('%B') for m in monthly_avg.index])

plt.tight_layout()

plt.savefig(f"{plot_output}/{selected_year}_monthly_average_plot.png", dpi=300)
#plt.show()




################################################################################################################
################################################################################################################
################################################################################################################


####                                    Monthly average uptime

def convert_minutes_to_hours_minutes(total_minutes):
    hours = int(total_minutes) // 60
    minutes = int(total_minutes) % 60
    return f"{hours}h {minutes}m"



#### Format the numbers and convert the month numbers to names
monthly_avg_formatted = monthly_avg.apply(convert_minutes_to_hours_minutes)

month_names = monthly_avg.index.map(lambda m: pd.to_datetime(str(m), format='%m').strftime('%B'))


#### Create a Series with clean month names and no column name
monthly_avg_named = pd.Series(monthly_avg_formatted.values, index=month_names)
monthly_avg_named.index.name = None  #### Remove index name
monthly_avg_named.name = None        #### Remove Series name



#print(f"Monthly Average Uptime:\n{monthly_avg_named.to_string()}")

monthly_avg_output_str = f"Monthly Average Uptime:\n{monthly_avg_named.to_string()}"

with open(monthly_avg_txt_output, 'w') as f:
    f.write(monthly_avg_output_str)


################################################################################################################
################################################################################################################
################################################################################################################



# ####                                        Daily uptime in the selected year

# ### Filter the dataframe for the selected year
# df_year = df[df['DATE'].dt.year == selected_year]


# #### Format date for x-axis without year
# x_labels = df_year['DATE'].dt.strftime('%b %d')


# #plt.figure(figsize=(10, 4))
# plt.figure(figsize=(24, 12))


# #plt.plot(x_labels, df_year['Uptime_minutes'], marker='o', linestyle='-')
# plt.plot(x_labels, df_year['Uptime_minutes'], linestyle='-')


# plt.title(f'Uptime Over Time in {selected_year}')
# plt.xlabel('Date')


# plt.ylabel('Uptime in Minutes (720m = 12h)')


# plt.xticks(rotation=90)
# plt.tight_layout()



# plt.savefig(f"{plot_output}/{selected_year}_daily_uptime_plot.png", dpi=300)
# #plt.show()