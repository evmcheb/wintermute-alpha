from eth_account.signers.local import LocalAccount
from web3 import Web3, HTTPProvider, WebsocketProvider
from eth_account.account import Account
import os
import requests
import json

FB_RELAY = "https://relay.flashbots.net"

def send_flashbots_bundle(txs, block_number):
    payload = {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "eth_sendBundle",
        "params": [{"txs": txs, "blockNumber": block_number}]
    }
    headers = {"Content-Type": "application/json"}
    
    try:
        response = requests.post(FB_RELAY, json=payload, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"An error occurred: {e}")
        return None

w3 = Web3(WebsocketProvider("wss://mainnet.infura.io/ws/v3/9643098acd134466a7b6d2d1364ff18d"))

# Subscribe to pending transactions
def handle_event(event):
    print(f"New pending transaction: {event['hash'].hex()}")

# Create a filter for pending transactions
pending_filter = w3.eth.filter('pending')

# Set up an event loop to process new pending transactions
while True:
    for event in pending_filter.get_new_entries():
        handle_event(event)
