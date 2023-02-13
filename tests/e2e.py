import requests

print(requests.get("http://127.0.0.1:3000/ping", timeout=10).json())
