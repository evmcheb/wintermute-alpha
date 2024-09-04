# Whitehat - Tier 2
You stumbled across an old [bug bounty report](https://medium.com/immunefi/polygon-lack-of-balance-check-bugfix-postmortem-2-2m-bounty-64ec66c24c7d) from the end of 2021 related to the Polygon codebase. Understanding that other blockchains are using this code, you decide to double-check that the largest ones are not susceptible to vulnerabilities disclosed in this report.


- a) Find at least two Polygon forks that could potentially be vulnerable.

Start by digging through the bor repo around the time of the patch. I found that on December the 7th, there was a patch released
to fix the bug: [Patch commit](https://github.com/maticnetwork/bor/commit/39116e6cc9c671a09f665b0f9c69157e279dacb1)

A good place to look for the vulnerability would be at the commit before, around [this commit](https://github.com/maticnetwork/bor/tree/d3010f49bd7be9399e92404e19e35dd7cca397b1)

By searching strings containing `0000000000000000000000000000000000001010` in the vulnerable bor repo I found that 

in [command/server/chains/allocs/mainnet.json](https://github.com/maticnetwork/bor/blob/d3010f49bd7be9399e92404e19e35dd7cca397b1/command/server/chains/allocs/mainnet.json) there is a file that stores the contracts to be initialized in the contract block.

It is read in 
```
var mainnetBor = &Chain{
    ....
	Genesis: &core.Genesis{
        ........
		Alloc:      readPrealloc("allocs/mainnet.json"),
	},
}
```

so repos that are using a similar pattern of code are likely to be vulnerable

Using Github string searching I found that [BTTC chain](https://github.com/bttcprotocol/bttc) is a bor fork. 

```
//DefaultBttcMainnet returns the Bor Mainnet network gensis block.
func DefaultBttcMainnetGenesisBlock() *Genesis {
	return &Genesis{
		Alloc:      readPrealloc("allocs/bttc-mainnet.json"),
	}
}
```
There is a contract deployed at 0x1010 on mainnet.

https://bttcscan.com/address/0x0000000000000000000000000000000000001010#code

It appears that the contract no longer has a transferWithSig function so I can tried to figure out when it was patched.
Using v1.0.0 of the BTTC blockchain, 

```
func DefaultGenesisBlock() *Genesis {
	return &Genesis{
		Config:     params.MainnetChainConfig,
		Nonce:      66,
		ExtraData:  hexutil.MustDecode("0x11bbe8db4e347b4e8c937c1c8370e4b5ed33adb3db69cbdb7a38e1e50b1b82fa"),
		GasLimit:   5000,
		Difficulty: big.NewInt(17179869184),
		Alloc:      decodePrealloc(mainnetAllocData),
	}
}
```

where the prealloc has been stored in a long hex string. 
```
const mainnetAllocData = "\xfa\x04]X\u0793\r\x83b\x011\x8e ...
```
But the prealloc doesn't include code setting. Just addresses and balances:
```
func decodePrealloc(data string) GenesisAlloc {
	var p []struct{ Addr, Balance *big.Int }
	if err := rlp.NewStream(strings.NewReader(data), 0).Decode(&p); err != nil {
		panic(err)
	}
	ga := make(GenesisAlloc, len(p))
	for _, account := range p {
		ga[common.BigToAddress(account.Addr)] = GenesisAccount{Balance: account.Balance}
	}
	return ga
}
```

My conclusion from this is that the BTTC chain went live on Dec 12th, 2021 without a precompile contract at 0x1010.
The precompile was added at this commit https://github.com/bttcprotocol/bttc/commit/f11d07437c607f7b9d3045d6da318cd67abdb190

I used the heimdall-rs decompiler and we can see the patch has the transferWithSig function nulled out.
![https://i.imgur.com/6Dp1HNY.png](https://i.imgur.com/6Dp1HNY.png)

My conclusion from this is that BTTC was never vulnerable as the blockchain was launched with no contract at 0x1010. 
It was added later in March 2023 with the transferWithSig function removed.

- b) Provide the code to check if these blockchains are safe.
```
forge test --match-path test/05-whitehat.sol --fork-url https://polygon-rpc.com --fork-block-number 21156660
The forge test passes
```

```
forge test --match-path test/05-whitehat.sol --fork-url https://rpc.bt.io
The script fails
```

- c) Estimate the potential maximum loss if this attack is possible on both blockchains.

There is 9,971 trillion BTT in the 0x1010 contract which could all be stolen by looping the contract call. 

BTT is a bridged contract from the Tron network that uses a mint/burn mechanism. The bridge contract [currently holds 29mm USD of assets](https://tronscan.org/#/contract/TU1CmpmWbCrFXqLLqMaKL2Q1d34bJNYLJe). including:
- $22mm BTT
- $3.7mm USDD
- $2.6mm HTX
- $260k USDT

I checked Kyberswap, Sushiswap, Mdex, ISwap and JustMoney but there are no [pools on BTTC](https://bttc.bittorrent.com/ecosystem) with any significant liquidity. It would be impossible to accumulate any other token apart from BTT post-hack. 

The BTTC bridge uses [permissioned relayers](https://doc.bt.io/docs/bridge/relayer/) to call the mint/burn functions on the main TRX chain. Assuming that the relayers do not have a maximum transfer amount, the attacker could drain all the BTTC in the deposit contract for a total loss of ~$22mm USD.

Additionally this hack will cause irreparable damage to the BTT token's reputation, likely resulting a 20-50% loss to its $990mm market cap. 