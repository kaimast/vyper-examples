stored_data: int128
owner: address

@external
def __init__(contract_owner: address, initial_value: int128):
  self.owner = contract_owner
  self.stored_data = initial_value

@external
def set(new_val: int128):
  if msg.sender != self.owner:
    raise "Not authorized"

  self.stored_data = new_val

@external
@view
def get() -> int128:
  # No point in doing access control here; data is public on the chain
  return self.stored_data
