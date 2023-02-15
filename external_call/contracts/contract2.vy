import contract1 as Contract1

@external
def __init__():
    pass

@external
def main_func(_to_call: address) -> uint256:
    other_contract: Contract1 = Contract1(_to_call)
    return other_contract.other_func()