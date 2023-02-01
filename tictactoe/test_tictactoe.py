#pylint: disable=missing-docstring,redefined-outer-name

import pytest

@pytest.fixture
def ttt_contract(w3, get_vyper_contract):
    with open("tictactoe.vy", encoding='utf-8') as code_file:
        code = code_file.read()
    args = [w3.eth.accounts[0], w3.eth.accounts[1]]
    return get_vyper_contract(code, *args)

def test_initial_state(ttt_contract):
    ''' Check if the constructor of the contract is set up properly '''
    assert ttt_contract.count_set_fields() == 0

def test_set(w3, ttt_contract, get_vyper_logs):
    tx_hash = ttt_contract.set(0, 1, transact={"from": w3.eth.accounts[0]})
    events = get_vyper_logs(tx_hash, ttt_contract, "Move")
    assert len(events) == 1
    tx_hash = ttt_contract.set(1, 1, transact={"from": w3.eth.accounts[1]})
    events = get_vyper_logs(tx_hash, ttt_contract, "Move")
    assert len(events) == 1
    assert ttt_contract.count_set_fields() == 2

def test_win0(w3, ttt_contract, get_vyper_logs):
    assert not ttt_contract.has_winner()

    ttt_contract.set(0, 0, transact={"from": w3.eth.accounts[0]})
    ttt_contract.set(1, 0, transact={"from": w3.eth.accounts[1]})
    ttt_contract.set(0, 1, transact={"from": w3.eth.accounts[0]})

    assert not ttt_contract.has_winner()

    ttt_contract.set(1, 1, transact={"from": w3.eth.accounts[1]})
    ttt_contract.set(0, 2, transact={"from": w3.eth.accounts[0]})

    assert ttt_contract.has_winner()
    assert ttt_contract.get_winner() == w3.eth.accounts[0]

def test_win1(w3, ttt_contract, get_vyper_logs):
    assert not ttt_contract.has_winner()

    ttt_contract.set(1, 0, transact={"from": w3.eth.accounts[0]})
    ttt_contract.set(0, 0, transact={"from": w3.eth.accounts[1]})
    ttt_contract.set(0, 1, transact={"from": w3.eth.accounts[0]})

    assert not ttt_contract.has_winner()

    ttt_contract.set(1, 1, transact={"from": w3.eth.accounts[1]})
    ttt_contract.set(0, 2, transact={"from": w3.eth.accounts[0]})

    assert not ttt_contract.has_winner()

    ttt_contract.set(2, 2, transact={"from": w3.eth.accounts[1]})

    assert ttt_contract.has_winner()
    assert ttt_contract.get_winner() == w3.eth.accounts[1]
