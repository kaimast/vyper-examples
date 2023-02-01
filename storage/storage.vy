stored_data: public(int128)

@external
def __init__(initial_val: int128):
  self.stored_data = initial_val

@external
def set(new_val: int128):
  self.stored_data = new_val
