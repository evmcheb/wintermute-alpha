# DAOs - Tier 1
You’re a DeFi enthusiast who spends a lot of time participating in and analyzing DAOs, their governance contracts, and their overall level of participation. Over the past couple of years, the market has slowed down and you’ve begun to notice that some DAOs are not the same as they used to be.


- a) Identify a set of DAOs that are most vulnerable to an economic governance attack, describe how it may be achieved, and estimate the cost to the attacker.

## Vulnerable DAOs
Here are some features that could make a DAO economically vulnerable:
- DAOs with large treasuries and a depressed gov. token price.
    - Make it a good risk/reward opportunity for attackers
- Older DAOs with low participation rates and high decentralization
    - Makes it difficult to instigate defensive action within the voting time frame. 
- DAOs with a high % of their treasury as liquid tokens.
    - Attractive as the bounty can be easily sold
- DAOs that have tokens in lending markets
    - Makes it easy to accumulate a large amount of tokens in a short amount of time.

Defi V1 protocols like Compound, MakerDAO, TribeDAO, Frax, Tokemak, Pangolin and Benqi have a lot of these features and could be vulnerable to an economic governance attacks.

Note: the data was sourced from [DeepDao](https://deepdao.io/organizations)

## Attack process
The best time for an attack would be a weekend or holiday so a propsal is less likely to be noticed. The attacker could borrow tokens on a money market or buy spot tokens and hedge using CeFi futures. They could even bribe existing whales to delegate stake to them for the promise of future profit!

Malicious proposals could take the form of sending a % of the treasury to the attacker, force integration into another protocol, or overtake the DAO multisig entirely.

Given the attacker has enough collateral (10-50mm should be enough for most vulnerable DAOs), the cost to an atttacker is minimal and is essentially a free option. For every $1 of spot token the attacker accumulates through CeFi exchanges, money markets or onchain pools, they can hedge on futures by short selling the same amount. 

They will only pay funding rates during the period they hold the position. Over a few days this is usually <1% of the position size. 

- b) For vulnerable DAOs, estimate and describe the potential benefit for the attacker i.e., how much of the DAO’s treasury is at risk of being stolen? (it can also be a parameter change)

COMP has completed the vast majority of its vesting period which has [84mm of liquid treasury](https://deepdao.io/organization/52bf381b-79a8-4498-8504-41961beda494/organization_data/finance). This is all at risk of being stolen by an attacker. 

15.5% (13mm) of the treasury is in ETH, which shouldn't be affected by the hack price wise. 

83% (70mm) is in COMP, which is currently trading at $44.5. The market would price in a treasury drain negatively. After including slippage, I estimate the attacker may be able to extract 50-60% of this value. ~25% negative news price impact and 25% slippage. 

I estimate a complete takeover to be a 50-60mm profit. The attacker could even short-sell the asset before the attack takes place, extracting even more profit.

- Use COMP money markets and exchanges to buy spot tokens. Hedge exposures using CeFi futures. 
- Drain the COMP treasury by submitting a proposal to transfer the treasury into a wallet controlled by the attacker. 
- Once the vote is near completion, hedge the treasury hack on futures.
- Sell the stolen tokens on the open market. 
- Unwind the futures positions. 