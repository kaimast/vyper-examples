# Simple token that can be exchanged for exactly 1ETH

balances: public(HashMap[address, uint256])
total_supply: public(uint256)

@external
def __init__():
    self.total_supply = 0

@external
@payable
def buy() -> bool:
    self.total_supply += msg.value
    self.balances[msg.sender] += msg.value
    return True

@external
def sell(_value: uint256):
    assert self.balances[msg.sender] >= _value, "Not enough funds available"
    send(msg.sender, _value)
    self.total_supply -= _value
    self.balances[msg.sender] -= _value

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
