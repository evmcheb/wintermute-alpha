import math
import sys

def mul_div(a, b, denominator):
    return (a * b) // denominator

def sqrt(x):
    return int(math.sqrt(x))


def compute_profit_maximizing_trade(eth_reserve, tusd_reserve, fair_price):
    true_price_eth = int(1e18)  # 1 ETH in wei
    true_price_tusd = int(fair_price * 1e18)  # TUSD price in wei

    eth_to_tusd = mul_div(eth_reserve, true_price_tusd, tusd_reserve) < true_price_eth

    invariant = eth_reserve * tusd_reserve

    if eth_to_tusd:
        left_side = sqrt(mul_div(invariant * 1000, true_price_eth, true_price_tusd * 997))
        right_side = (eth_reserve * 1000) // 997
    else:
        left_side = sqrt(mul_div(invariant * 1000, true_price_tusd, true_price_eth * 997))
        right_side = (tusd_reserve * 1000) // 997

    if left_side < right_side:
        return False, 0

    amount_in = left_side - right_side
    return eth_to_tusd, amount_in

def get_amount_out(amount_in, reserve_in, reserve_out):
    if amount_in <= 0:
        raise ValueError('INSUFFICIENT_INPUT_AMOUNT')
    if reserve_in <= 0 or reserve_out <= 0:
        raise ValueError('INSUFFICIENT_LIQUIDITY')
    amount_in_with_fee = amount_in * 997
    numerator = amount_in_with_fee * reserve_out
    denominator = reserve_in * 1000 + amount_in_with_fee
    amount_out = numerator // denominator
    return amount_out

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python profit.py <eth_reserve> <tusd_reserve> <fair_price>")
        sys.exit(1)

    eth_reserve = int(float(sys.argv[1]) * 1e18)  # Convert ETH to wei
    tusd_reserve = int(float(sys.argv[2]) * 1e18)  # Convert TUSD to wei
    fair_price = float(sys.argv[3])
    print(f"Fair price: {fair_price:.3f}")

    print("Checking arb ETH->TUSD")
    arb_exists, amount_in = compute_profit_maximizing_trade(eth_reserve, tusd_reserve, fair_price)
    if arb_exists:
        amount_out = get_amount_out(amount_in, eth_reserve, tusd_reserve)
        reserves_after = (eth_reserve + amount_in, tusd_reserve - amount_out)
        price = amount_out / amount_in
        profit = (price - fair_price) * amount_in / 1e18
        print(f"Amount ETH in: {amount_in / 1e18:.3f}")
        print(f"Trade price: {price:.3f}")
        print(f"Profit: {profit:.3f}")
        print(f"Pool prices after arb: {reserves_after[1] / reserves_after[0]:.3f}")
    else:
        print("No arb")

    print("Checking arb TUSD->ETH")
    arb_exists, amount_in = compute_profit_maximizing_trade(tusd_reserve, eth_reserve, 1/fair_price)
    if arb_exists:
        amount_out = get_amount_out(amount_in, tusd_reserve, eth_reserve)
        reserves_after = (eth_reserve - amount_out, tusd_reserve + amount_in)
        price = 1/(amount_out / amount_in)
        profit = (fair_price - 1/price) * amount_in / 1e18
        print(f"Amount TUSD in: {amount_in / 1e18:.3f}")
        print(f"Trade price: {price:.3f}")
        print(f"Profit: {profit:.3f}")
        print(f"Pool prices after arb: {reserves_after[1] / reserves_after[0]:.3f}")
    else:
        print("No arb")