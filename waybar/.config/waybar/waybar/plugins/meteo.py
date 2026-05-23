#!/usr/bin/env python3
import urllib.request
import json
from datetime import datetime

# Coordinates for Bolzano
lat, lon, city = 46.49, 11.33, "Bolzano"

def get_data(url):
    with urllib.request.urlopen(url) as response:
        return json.loads(response.read().decode())

try:
    # 1. Get location based on IP if not hardcoded
    if not lat or not lon or not city:
        geo = get_data("http://ip-api.com/json/")
        lat, lon, city = geo["lat"], geo["lon"], geo["city"]

    # Added 'is_day' to the params
    params = "current=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m,is_day"
    weather_url = f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&{params}"
    data = get_data(weather_url)

    current = data["current"]
    temp = round(current["temperature_2m"])
    humidity = current["relative_humidity_2m"]
    wind = current["wind_speed_10m"]
    precip = current["precipitation"]
    code = current["weather_code"]
    is_day = current["is_day"]  # 1 for day, 0 for night

    now = datetime.now().strftime("%H:%M")

    # 2. Weather Emoji Mapping (Day vs Night)
    # Format: code: [Day_Icon, Night_Icon]
    description = {
        0:  ["☀️", "🌙"],      # Clear
        1:  ["🌤️", "☁️"],      # Mainly Clear
        2:  ["⛅", "☁️"],      # Partly Cloudy
        3:  ["☁️", "☁️"],      # Overcast
        45: ["🌫️", "🌫️"],     # Fog
        48: ["🌫️", "🌫️"],     # Depositing rime fog
        51: ["🌦️", "🌧️"],     # Drizzle
        61: ["🌧️", "🌧️"],     # Rain
        71: ["❄️", "❄️"],      # Snow
        95: ["🌩️", "🌩️"],     # Thunderstorm
    }

    # Pick the icon based on code and day/night status
    icons = description.get(code, ["🌡️", "🌡️"])
    icon = icons[0] if is_day == 1 else icons[1]

    # 3. Format Output
    out = {
        "text": f"{icon} {temp}°C",
        "tooltip": (
            f"📍 {city}\n"
            f"-------------------\n"
            f"💧 Humidity: {humidity}%\n"
            f"💨 Wind: {wind} km/h\n"
            f"🌧️ Precip: {precip} mm\n"
            f"-------------------\n"
            f"🕒 Updated: {now}"
        ),
    }
    print(json.dumps(out))

except Exception as e:
    print(json.dumps({"text": "󰖪 Off", "tooltip": f"Error: {str(e)}"}))
