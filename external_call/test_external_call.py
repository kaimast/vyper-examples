#pylint: disable=missing-docstring,redefined-outer-name

import pytest

@pytest.fixture
def contract1(w3, get_vyper_contract):
    with open("contracts/contract1.vy", encoding='utf-8') as infile:
        contract_code = infile.read()

    return get_vyper_contract(contract_code)

@pytest.fixture
def contract2(w3, get_vyper_contract, contract1):
    with open("contracts/contract2.vy", encoding='utf-8') as infile:
        contract_code = infile.read()

    return get_vyper_contract(contract_code, contract1.address)

def test_call(w3, contract2):
    contract2.main_func()
