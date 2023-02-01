# @version ^0.3

BOARD_SIZE: constant(uint256) = 3

EMPTY: constant(int256) = -1
CIRCLE: constant(int256) = 0
CROSS: constant(int256) = 1

players: address[2]
next_player: int256

winner: int256

values: int256[BOARD_SIZE][BOARD_SIZE]

# A player made a move
event Move:
    pos_x: uint256
    pos_y: uint256
    val: int256

# A player won
event Winner:
    player: address

@external
def __init__(player1: address, player2: address):
    self.players = [player1, player2]
    self.next_player = 0
    self.winner = EMPTY

    for i in range(BOARD_SIZE):
        for j in range(BOARD_SIZE):
            self.values[i][j] = EMPTY

@external
def set(i: uint256, j: uint256):
    from_player: int256 = 0

    if msg.sender == self.players[0]:
        from_player = CIRCLE
    elif msg.sender == self.players[1]:
        from_player = CROSS
    else:
        raise "Sender is no a player"

    if from_player != self.next_player:
        raise "Not your turn!"

    if self.values[i][j] != EMPTY:
        raise "Field was already set"

    self.values[i][j] = from_player
    self.next_player = (self.next_player + 1) % 2

    log Move(i, j, from_player)

    if self.check_winner(from_player):
        self.winner = from_player
        log Winner(msg.sender)

@external
@view
def get(i: uint256, j: uint256) -> int256:
    return self.values[i][j]

@internal
def check_winner(from_player: int256) -> bool:
    # rows
    for i in range(BOARD_SIZE):
        won: bool = True
        for j in range(BOARD_SIZE):
            if self.values[i][j] != from_player:
                won = False
        if won:
            return True

    # columns
    for i in range(BOARD_SIZE):
        won: bool = True
        for j in range(BOARD_SIZE):
            if self.values[j][i] != from_player:
                won = False
        if won:
            return True

    # diagonal 1
    won: bool = True
    for i in range(BOARD_SIZE):
        if self.values[i][i] != from_player:
            won = False
    if won:
        return True

    # diagonal 2
    won = True
    for i in range(BOARD_SIZE):
        if self.values[BOARD_SIZE-1-i][i] != from_player:
            won = False
    if won:
        return True

    return False

@external
@view
def has_winner() -> bool:
    return self.winner != EMPTY

@external
@view
def get_winner() -> address:
    if self.winner != EMPTY:
        return self.players[self.winner]

    raise "No winner yet!"

@external
@view
def count_set_fields() -> uint256:
    count: uint256 = 0

    for i in range(BOARD_SIZE):
        for j in range(BOARD_SIZE):
            if self.values[i][j] != EMPTY:
                count += 1

    return count
