#pylint: disable=missing-docstring,redefined-outer-name

import pytest
from decimal import Decimal

@pytest.fixture
def token_contract(get_vyper_contract):
    with open("token.vy", encoding='utf-8') as infile:
        contract_code = infile.read()

    return get_vyper_contract(contract_code)

def test_balance(w3, token_contract):
    account = w3.eth.accounts[0]

    token_contract.buy(transact={"from": account, "value": 5})
    assert token_contract.my_balance(call={"from": account}) == 5
    assert token_contract.my_voting_power(call={"from": account}) == Decimal('100.0')

def test_voting_power(w3, token_contract):
    account1 = w3.eth.accounts[0]
    account2 = w3.eth.accounts[1]

    token_contract.buy(transact={"from": account1, "value": 5})
    token_contract.buy(transact={"from": account2, "value": 15})

    assert token_contract.my_voting_power(call={"from": account1}) == Decimal('25.0')
    assert token_contract.my_voting_power(call={"from": account2}) == Decimal('75.0')
