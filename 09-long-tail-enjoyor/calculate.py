from web3 import HTTPProvider, Web3
import json
import concurrent.futures

w3 = Web3(HTTPProvider("https://eth.merkle.io"))
data = json.load(open("txns.json"))
txn_hashes = data['result']['rows']
oneinch_contracts = set([
    w3.to_checksum_address("0x11111112542d85b3ef69ae05771c2dccff4faa26"),
    w3.to_checksum_address("0x1111111254fb6c44bac0bed2854e76f90643097d"),
    w3.to_checksum_address("0x1111111254eeb25477b68fb85ed929f73a960582"),
])

abi = '''[{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}]'''
weth = w3.eth.contract(
    address=w3.to_checksum_address("0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"), abi=abi
)
multicall = w3.eth.contract(
    address=w3.to_checksum_address("0x5BA1e12693Dc8F9c48aAD8770482f4739bEeD696"),
    abi=[{"inputs":[{"components":[{"internalType":"address","name":"target","type":"address"},{"internalType":"bytes","name":"callData","type":"bytes"}],"internalType":"struct Multicall3.Call[]","name":"calls","type":"tuple[]"}],"name":"aggregate","outputs":[{"internalType":"uint256","name":"blockNumber","type":"uint256"},{"internalType":"bytes[]","name":"returnData","type":"bytes[]"}],"stateMutability":"payable","type":"function"}]
)

def get_value(contract_address, sender_address, block_number):
    calls = [
        (weth.address, weth.encodeABI(fn_name="balanceOf", args=[contract_address])),
        (weth.address, weth.encodeABI(fn_name="balanceOf", args=[sender_address]))
    ]
    _, return_data = multicall.functions.aggregate(calls).call(block_identifier=block_number)
    weth_bal_contract, weth_bal_sender = [int.from_bytes(data, byteorder='big') for data in return_data]
    eth_bal_contract = w3.eth.get_balance(contract_address, block_number)
    eth_bal_sender = w3.eth.get_balance(sender_address, block_number)
    return float(weth_bal_contract + weth_bal_sender + eth_bal_contract + eth_bal_sender) / 1e18

def process_transaction(tx):
    to_address = w3.to_checksum_address(tx['to'])
    from_address = w3.to_checksum_address(tx['from'])
    if to_address not in oneinch_contracts:
        hash = tx['tx_hash']
        pre_tx_block = tx['block_number'] - 1
        # Get the last 32 bytes of the event
        amount = int(tx['data'][-64:], 16)/1e18

        pre_tx_balance = get_value(to_address, from_address, pre_tx_block)
        post_tx_balance = get_value(to_address, from_address, tx['block_number'])

        extracted_value = post_tx_balance - pre_tx_balance
        return f"Block {tx['block_number']}\tTo: {to_address}\tAmount: {amount:.3f} ETH\tExtracted: {extracted_value:.3f} ETH\tHash: {hash}"
    return None

for tx in txn_hashes:
    result = process_transaction(tx)
    if result:
        print(result)