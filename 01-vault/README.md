# Vault - Tier 1
You are looking through an old version of the OpenZeppelin implementation of ERC-4626 and notice a vulnerability that requires frontrunning an innocent user. You have been granted a large amount of ETH (say e.g. 1k ETH, but you are free to choose the amount :) ) and want to set up a whitehat bot to execute this exploit and return the funds to the user.


- a) Describe the vulnerability and the payoffs for an attacker.

[OpenZeppelin's ERC-4626 implementation](https://docs.openzeppelin.com/contracts/4.x/erc4626) (versions < 4.9) is vulnerable to an inflation attack. 
In empty or near empty vaults, an attacker needs to wait for an innocent user to deposit assets into the vault expecting to receive shares.


While monitoring the mempool for pending transactions, the attacker can:

1. Detect a pending deposit transaction from an innocent user into an empty vault.
2. Frontrun it with a minimal deposit of assets to gain majority ownership of the empty vault.
3. Directly transfers (donates) assets to the vault, exceeding the innocent user's deposit amount.
4. When the user's transaction executes, the vault calculates shares based on `balanceOf(address(this))`.
5. Due to the inflated asset balance, the user is entitled to < 1 wei of shares.
6. As the EVM only supports integer shares, the victim's shares are rounded down to 0, effectively donating the user's assets to the attacker.

In empty/very near empty vaults, the attacker can make away with 100% of the user deposit. 
In small vaults, the user may suffer double digit % losses. 


For example, if the attacker can manipulate the rates such that the innocent user deserves 1.99 shares, this will be rounded down to 1 wei, resulting in nearly a 50% loss. This loss is effectively donated to the existing shareholders of the vault, including the attacker.


- b)  Produce code that can check if this vulnerability has occurred in the past and determine how much value was lost, if any.

We look for two ERC-4626 deposit events in one block, where the first deposit takes up 100% of the vault, and the second deposit receives <2 shares.

- c)  Write code for the bot that can carry out the exploit (don’t worry about returning user funds).

I used version 4.8 of OZ's ERC4626.

The test file for this exploit can be found here: [01-vault.sol](../test/01-vault.sol)

```
forge test --match-path test/01-vault.sol -vvv
```