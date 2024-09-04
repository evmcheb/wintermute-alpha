# Pump-It - Tier 2
You notice the growing attention around pump.fun and can't help but take a deeper look. You are interested in their revenue sources and observe that they take fees for a few distinct actions.


- a) How much revenue did Pump generate and can you decompose this for each action? E.g. [pump.fun](http://Pump.Fun) takes fees for each trade on the bonding curve, so one revenue component would be the sum of all “trades via the bonding curve” (the distinct action).

The pump fun fee account is [CebN5WGQ4jvEPvsVU4EoHEpgzq1VV7AbicfhtW4xC9iM](https://solscan.io/account/CebN5WGQ4jvEPvsVU4EoHEpgzq1VV7AbicfhtW4xC9iM)
- Buys and sells on the bonding curve (1%)

The pump fun raydium migration account is [39azUYFWPz3VHgKCf3VChUwbpURdCHRxjWVowf5jUJjg](https://solscan.io/account/39azUYFWPz3VHgKCf3VChUwbpURdCHRxjWVowf5jUJjg).
- Flat 2 SOL (recently changed to 1.5 SOL) when the token is deployed to Raydium

Buys and sells: https://dune.com/queries/4042724

`Sell revenue: 270,460 SOL`

`Buy revenue: 282,898 SOL`

Raydium deploys:
https://dune.com/queries/4042925

`before_aug_9_2024: 16425 deploys * 2 SOL = 32,850 SOL`

`on_or_after_aug_9_2024: 3254 deploys * 1.5 SOL = 4881 SOL`

Total Migration revenue: 37,731 SOL

Total Revenue: 270,460 + 282,898 + 37,731 = 591,089 SOL


- b) What percentage of tokens were successfully deployed to Raydium? Find the tokens that:
    - Took the most time to deploy to Raydium.
    - Took the least amount of time to deploy to Raydium.

https://dune.com/queries/4043011

Total number of creations: 
`1,946,499`

Total number of migrations: 
`16425 + 3254 = 19679`

Percentage of tokens successfully deployed to Raydium:
`(19679 / 1946499) * 100 = 1.01%`

Most and least time to deploy. Final column `time_difference` is in seconds.

https://dune.com/queries/4043020

```
create_id,deploy_id,token_mint,pc_mint,create_time,deploy_time,time_difference
4sNES9ML9TekNBtp9u5vnt6ThWuosHYAsXyt8ZQfESU7ppVdt3EKTcsZHFrmn8EdYHBGQ4VrovGA4Y1EmSHcWoRZ,4FgF8rZHHFVZahtr9fqh67Th7HTphnYswqkxAdasmimwDzYzNmEj6uLPBxzfVpQ94goGwHkTe8vMwbPQPoQ6YcYL,C1zbYRGs2kXKxuFxf1Nb4VrXy2x6e1bYpVUxLDBgiwgk,C1zbYRGs2kXKxuFxf1Nb4VrXy2x6e1bYpVUxLDBgiwgk,2024-01-18 12:46:24.000 UTC,2024-08-16 05:51:51.000 UTC,1.8205527e+07
44pDvaYhCEkpoH9zQDQzjrJf1HenKeUtxxm1hvhWNcRsAs6Qr14q75A2DmWq7PshMc4PCNiRhcJ3ost95D3ziKQR,2Vkgb9wovj6FJudPHxU5JZwjdVpXaSRRTA1rumLHouvyZ8yjsKXUHpPi3Eu9fiYuCTZKY3NLemEBB6b97kS1E1Gt,6wutLrRDwCUNSiete4i7oKtZuehWCGRn7gJT7FH6qTbQ,6wutLrRDwCUNSiete4i7oKtZuehWCGRn7gJT7FH6qTbQ,2024-01-20 01:06:04.000 UTC,2024-08-12 10:49:49.000 UTC,1.7747025e+07
48EgUG4umXjdqrArqxdvnAn2Xd2Ya8MgezQx3Y92BL9BNap2FQVnUqTHv15nB8o3AULJkBmcWRtsE6ZsoawcxioC,3e4KbpeoxpGEyqRwGoH1bvXw5X9yd3WdE4K58gXtZ99UNo8JRiKDETEa4uUtJAjUrEnBMq5tj3P75Uzr8hjGcwFW,CcqND4YtwSqDDTkF4Y3TTWauVC28iJxFYaJiaJtpE5xd,CcqND4YtwSqDDTkF4Y3TTWauVC28iJxFYaJiaJtpE5xd,2024-01-19 21:13:24.000 UTC,2024-08-12 05:50:27.000 UTC,1.7743023e+07
4JvhvEDzmabCxt3pruzLzPwBGNTdMdZ9XaVumnvjxoLmSvQCHPkM5ETbKAdzcmkQb5NW4VTmBNa5R8QaAKAJ5DA5,2MCrxXbaZ1yAVw1ioppYdzEDEtBcEji7Xf98LSSNqVSXF8uCb4yEfSUJVdrVSCSWNcqPm4YWstg8yHgsYkGoR7JW,8nnQqmHBLEaRoMHuotm7y6XWLm68vMdPgNRML8Q3zsBa,8nnQqmHBLEaRoMHuotm7y6XWLm68vMdPgNRML8Q3zsBa,2024-01-23 18:13:18.000 UTC,2024-08-13 17:43:19.000 UTC,1.7537401e+07
3PtfgBWttJNLPKEFnT763MctmLNL1Q3wfp1jhqwb9UhooJtHdg5UKtYLLevkd4k66fU6DP6Bjkhqwnct5hyDfc7J,4KkrSr9QjQ22RRX4qG6MtoQXg3rogAT9ojEnNAgw6mMZHCZtVcEKW4JV8SujNrX9ULoUBwpbaKNj5tkaBZAfR3qZ,C9DRTdA25hzcqSfHdRYKtGEQ77kispxqTngRVJm3jS4A,C9DRTdA25hzcqSfHdRYKtGEQ77kispxqTngRVJm3jS4A,2024-02-16 22:27:58.000 UTC,2024-08-22 05:55:20.000 UTC,1.6183642e+07
```

Shortest times:

```
create_id,deploy_id,token_mint,pc_mint,create_time,deploy_time,time_difference
NGBaRa4GN2Cns6puGxV87YjAy46BVQKSszgyWvMBxLAvVFKQXeX3ZZL1zPLnsEp3XyLdsCpRUMGkTjjmSC5HUiC,24KCfhx6Vu9CKRHurLR381ndNujtM5TmC3k646mvHjJcGwjkAQU1dfSQR6iW2djzR5cBgsZPRYAoTqTS743FccyP,Ffbk7xXqoKdFCe8exjvt9yeJKajDG16RQJtfGUkXpump,Ffbk7xXqoKdFCe8exjvt9yeJKajDG16RQJtfGUkXpump,2024-07-01 07:16:29.000 UTC,2024-07-01 07:18:04.000 UTC,95
kh8ET4ZXMNzP9Pimu6BvwCJFV9wdpkPSNZR2wSWi1Qf7aq9WhjUJwzvD7c2awaUtbdNxLusRgSqi88yofHnpyRC,8wTSJHHWZcS9H1nB7u6dpfww3e5mA8fK5k5GeDXXd9EjGJUPLgqNmmBGRYj62WiQC8PnXMHc3iYPjwGUCmf7epX,Ef1Vymz8vhKeGQ9jbUj96Jncsr4Zs7j46FL5N4BHpump,Ef1Vymz8vhKeGQ9jbUj96Jncsr4Zs7j46FL5N4BHpump,2024-06-23 01:07:14.000 UTC,2024-06-23 01:08:49.000 UTC,95
3wsLCK18VVVt1Qo1JF2tRYDMfdPEzQuoxP8Qt8KGag98MiApDNL79PEVPhFJVNvwAw654uiJD794fgVwfkcpP3fZ,3Aimpsoai6cLjqcS1TfXTGNMebWQH1Fwk9qng4cEUpqXRCbe2Xn2GDaB2CbpU772qLof3YnZrEY1AJTwgBq4C2zK,brszdv8VQhTimugZZEcx5iaAJ6b8p4RCZKReVompump,brszdv8VQhTimugZZEcx5iaAJ6b8p4RCZKReVompump,2024-06-17 13:04:37.000 UTC,2024-06-17 13:06:13.000 UTC,96
3XzEFJRALoa6iqFWDfACJxvv9Ap4inoxDT4o6YfLzi8KcdatYsTCF5gGj13ToDkXoFhnuNoHdvxLLnjKCvdLa4TW,7LjhMgvBPcxgvEqfTBZ3A8Y54jNaM9wmgXxp8eXs1yddNZUo3qoLNkrx1Hx8gVxhgzamnV4Xf2gx1yX4G6d8ZuG,3PFiopPyR7wSB6nwyNWKCVWGiZCo6bvfnbovvgNxpump,3PFiopPyR7wSB6nwyNWKCVWGiZCo6bvfnbovvgNxpump,2024-06-14 22:27:33.000 UTC,2024-06-14 22:29:09.000 UTC,96
```

- c) Using the information gained from the above sub-questions about fee generation, were there any cases where the pump team had a clear incentive to buy any given token created through their platform? If yes, provide an example. If no, explain the conditions under which this incentive would exist.

Yes. The incentive exists when a token is less than 2 SOL (1.5 SOL after Aug 9, 2024) away from being fully deployed to Raydium. In such cases, the pump team would have an incentive to buy the token to trigger the migration and earn the 2 SOL (1.5 SOL) bonus.