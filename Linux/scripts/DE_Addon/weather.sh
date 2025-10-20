#!/bin/bash

#### Alternative source for open source weather pull

city="Latina"
lat=41.4673
lon=12.9037


declare -A weather_descriptions=(
  [0]="☀️"   # Clear sky
  [1]="🌤️"  # Mainly clear
  [2]="⛅"   # Partly cloudy
  [3]="☁️"   # Overcast
  [45]="🌫️"  # Fog
  [48]="🌫️"  # Fog (rime)

  [51]="🌦️"  # Light drizzle
  [53]="🌧️"  # Moderate drizzle
  [55]="🌧️"  # Dense drizzle

  [61]="🌧️"  # Light rain
  [63]="🌧️"  # Moderate rain
  [65]="🌧️"  # Heavy rain

  [66]="🌧️❄️" # Freezing rain
  [67]="🌧️❄️" # Freezing rain

  [71]="🌨️"  # Light snow
  [73]="🌨️"  # Moderate snow
  [75]="🌨️"  # Heavy snow
  [77]="🌨️"  # Snow grains

  [80]="🌦️"  # Light showers
  [81]="🌦️"  # Moderate showers
  [82]="🌧️"  # Heavy showers

  [85]="🌨️"  # Light snow showers
  [86]="🌨️"  # Heavy snow showers

  [95]="⛈️"  # Thunderstorm
  [96]="⛈️"  # Thunderstorm with hail
  [99]="⛈️"  # Thunderstorm with heavy hail
)


################################################################################################


while true; do
  data=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true")

  #### Check to avoid errors
  dataCheck=$(echo -e "$data" | grep "{" )

  if [ "$dataCheck" = "" ]; then
    sleep 5s
    exit 1
  fi
    


  #### Rounded to integer
  raw_temp=$(echo "$data" | jq -r '.current_weather.temperature')
  temp=$(LC_NUMERIC=C printf "%.0f" "$raw_temp")
  
  code=$(echo "$data" | jq -r '.current_weather.weathercode')


  if [ -n "$temp" ] && [ -n "$code" ]; then
  description=${weather_descriptions[$code]}
  echo "$description $temp°"
  break


  #### if the weather is not available, wait  
  else
    delay=$(($RANDOM % 12 + 5))
    sleep "$delay"s
    data=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true")

  fi

done










################################################################################################
################################################################################################
################################################################################################


#######                                   OLD




#### If the host is down it prints an error
#### Executor does NOT output anything until the code stopped running


# #### Weather from wttr.in --- already with the emojii
# city="Latina"
# weather=$(curl -s http://wttr.in/"$city"?format=3)

# while true
# do  
#     #### If the host is up i create the string and break
#     if echo "$weather" | grep -q "$city"; then
#         ####        remove everything before :                                remove + and C
#         ready=$( echo "$weather" | awk -F': ' '{print $2}' | awk '{$1=$1; gsub(/\+/, ""); gsub(/\C/, "") ; print}' )
        
#         echo  " $ready"
#         break

#     #### Give the host some time to come back up
#     else
#         sleep 5m
#         weather=$(curl -s http://wttr.in/"$city"?format=3)
#     fi
# done