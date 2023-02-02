# Examples for the Vyper Programming Language

Some basic Vyper programs we talked about in class. Currently, this contains three examples.
Each of them has a code file (ending with `.vy`) and a test script (starting with `test_`).

* `storage`: A simple get/set contract
* `access_control`: Similar to storage, but only allows authorized users to modify the value
* `tictactoe`: Have two accounts play a basic game against one another

## Prerequisites

Ideally, you run these script in a dedicated Python environment (e.g., using [virtualenv](https://virtualenv.pypa.io/en/latest/)).

1. Install pytest and vyper
```
pip install pytest vyper
```

2. Install pytest-vyper from github (the version on pip is outdated)
```
pip install git+https://github.com/kaimast/pytest-vyper
```

## Run Tests

You can run all tests using `make` or individual tests from within the directory of the example.

For example to test the storage contract, run `cd storage && pytest --disable-warnings`.
