#pylint: disable=missing-docstring,redefined-outer-name

import pytest

from eth_tester.exceptions import TransactionFailed

INITIAL_VALUE = 4

@pytest.fixture
def access_control_contract(w3, get_vyper_contract):
    owner = w3.eth.accounts[0]

    with open("access_control.vy", encoding='utf-8') as infile:
        contract_code = infile.read()

    contract = get_vyper_contract(contract_code, owner, INITIAL_VALUE)
    return contract

def test_set_authorized(w3, access_control_contract):
    new_value = 10

    owner = w3.eth.accounts[0]
    access_control_contract.set(new_value, transact={"from": owner})
    assert access_control_contract.get() == new_value

def test_set_not_authorized(w3, access_control_contract):
    other_acct = w3.eth.accounts[1]
    new_value = 10

    with pytest.raises(TransactionFailed):
        access_control_contract.set(new_value, transact={"from": other_acct})

    assert access_control_contract.get() == INITIAL_VALUE
