import .contract1 as Contract1

@external
def main_func(_to_call: address):
    other_contract: Contract1 = Contract1(_to_call)
    to_call.other_func()
