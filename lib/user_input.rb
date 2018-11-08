module UserInput
  UserRequest = Struct.new(:floor, :direction)

  DIRECTION_KEY = {
    'u' => 'up',
    'd' => 'down'
  }.freeze

  USER_INPUT_KEY = %w[1 2 3 4 5 6 7 8 9 10 u d q c].freeze

  def format_request(user_input)
    return exit if user_input == 'q'

    return DIRECTION_KEY[user_input] if %w[u d].include?(user_input)

    return 'error' unless USER_INPUT_KEY.include?(user_input)

    user_input.to_i < cab.current_floor ? result = UserRequest.new(user_input.to_i, 'down') : result = UserRequest.new(user_input.to_i, 'up')
    result
  end
end
