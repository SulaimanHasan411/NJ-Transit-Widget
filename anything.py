import requests

# Send a request to ipinfo.io to get geolocation data
response = requests.get('https://ipinfo.io/json')

if response.status_code == 200:
    data = response.json()
    location = data['loc'].split(',')
    latitude = location[0]
    longitude = location[1]

    print(f"Latitude: {latitude}, Longitude: {longitude}")
else:
    print("Failed to retrieve location data.")