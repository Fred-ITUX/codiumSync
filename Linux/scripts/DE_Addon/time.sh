#!/bin/bash

#### date +%a\ %b\ %d\ %Y\ %H:%M:%S
#### date +%a\ %b\ %d

# date=$(date +%a\,\ %b\ %d.%m\ \|\ %H:%M)

# date=$(date +%a\,\ %d.%m\ \|\ %H:%M)

# date=$(date +%a\,\ %d\ \|\ %H:%M)

date=$(date +%a\ %d\ \|\ %H:%M)
echo -e "$date"





#####################################################################
#####################################################################
#####################################################################

# #### Python datetime formatted
# from datetime import datetime
# now = datetime.now()

# #### date menu formatter --- gnome extension
# #### EEE, d | h:mm a


# #print(now.strftime("%a, %d | %I:%M %p   "))


# #### %B for full month name
# # print(now.strftime("%a, %B %b %m  %d | %H:%M"))

# print(now.strftime("%a, %d.%m | %H:%M"))