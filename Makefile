.PHONY: test-all

PYTEST:=pytest --disable-warnings

test-all:
	cd storage && ${PYTEST}
	cd access_control && ${PYTEST}
	cd tictactoe && ${PYTEST}
