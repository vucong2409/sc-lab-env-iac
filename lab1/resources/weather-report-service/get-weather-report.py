#!/usr/bin/python
import requests
import time

# Get temperature of Hanoi via a proxy
def get_current_han_temp_via_proxy(endpoint, proxy):
    res = requests.get(WTTR_HAN_ENDPOINT, proxies=proxies)
    if res.ok:
        print("Hanoi current temperature is ", res.text)
    else:
        print("Some error happened, please try again")

# Squid proxy endpoint
SQUID_PROXY_ADDR = "SQUID_PROXY_ADDR_GO_HERE"
# Hanoi weather report endpoint
WTTR_HAN_ENDPOINT = "https://wttr.in/hanoi?format=%t"
# Wait 10 seconds between queries
QUERY_DELAY_TIME = 10

# Use same proxy for every scheme
proxies = {
    "http": SQUID_PROXY_ADDR,
    "https": SQUID_PROXY_ADDR
}

while True:
    get_current_han_temp_via_proxy(WTTR_HAN_ENDPOINT, SQUID_PROXY_ADDR)
    time.sleep(QUERY_DELAY_TIME)
