# Simple token that can be exchanged for exactly 1ETH

balances: public(HashMap[address, uint256])
total_supply: public(uint256)

event Sell:
    seller: address
    value: uint256

event Buy:
    buyer: address
    value: uint256

@external
def __init__():
    self.total_supply = 0

@external
@payable
def buy():
    assert msg.value > 0
    self.total_supply += msg.value
    self.balances[msg.sender] += msg.value
    log Buy(msg.sender, msg.value)

@external
def sell(_value: uint256):
    assert _value > 0, "Value cannot be zero"
    assert self.balances[msg.sender] >= _value, "Not enough funds available"
    log Sell(msg.sender, _value)

    new_supply: uint256 = self.total_supply - _value
    new_balance: uint256 = self.balances[msg.sender] - _value

    # We can't use send here because it limits the amount of gas allowed
    # (this limit was added because of the DAO hack!)
    # send(msg.sender, _value)
    raw_call(msg.sender, b'', value=_value)

    self.total_supply = new_supply
    self.balances[msg.sender] = new_balance

@external
@view
def my_voting_power() -> decimal:
    total: decimal = convert(self.total_supply, decimal)
    usr_balance: decimal = convert(self.balances[msg.sender], decimal)

    if total == 0.0:
        return 0.0

    return (usr_balance / total) * 100.0

@external
@view
def my_balance() -> uint256:
    return self.balances[msg.sender]
