#pylint: disable=missing-docstring,redefined-outer-name

import pytest

INITIAL_VALUE = 4

@pytest.fixture
def storage_contract(w3, get_vyper_contract):
    with open("storage.vy", encoding='utf-8') as infile:
        contract_code = infile.read()

    return get_vyper_contract(contract_code, INITIAL_VALUE)

def test_initial_state(storage_contract):
    # Check if the constructor of the contract is set up properly
    assert storage_contract.stored_data() == INITIAL_VALUE

def test_set(w3, storage_contract):
    account = w3.eth.accounts[0]

    # Let k0 try to set the value to 10
    storage_contract.set(10, transact={"from": account})
    assert storage_contract.stored_data() == 10  # Directly access storedData

    # Let k0 try to set the value to -5
    storage_contract.set(-5, transact={"from": account})
    assert storage_contract.stored_data() == -5
