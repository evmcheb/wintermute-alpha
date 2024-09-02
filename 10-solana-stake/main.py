import asyncio

from solders.pubkey import Pubkey
from solana.rpc.async_api import AsyncClient
from solana.rpc.commitment import Confirmed
from solana.rpc.types import MemcmpOpts

STAKE_PROGRAM_ID: Pubkey = Pubkey.from_string("Stake11111111111111111111111111111111111111")


async def main():
    client = AsyncClient("https://api.mainnet-beta.solana.com", Confirmed)
    print("Connecting...")
    await client.is_connected()

    memcmp_opts = [MemcmpOpts(offset=124, bytes="CAf8jfgqhia5VNrEF4A7Y9VLD3numMq9DVSceq7cPh")] # put the pubkey of the validator vote address here
    response = await client.get_program_accounts(
        STAKE_PROGRAM_ID,
        encoding="base64",
        filters=memcmp_opts
    )
    print(response)
    #for stake in response['result']:
        #print(stake)

    await client.close()

asyncio.run(main())