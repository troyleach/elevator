module UserInput
  UserRequest = Struct.new(:floor, :direction, :priority)
  def format_request(user_input)
    # maybe in a class? or a module RequestHelpers
    # request = Struct.new(:floor, :direction)
    # I hate this here
    # I think I calc the direction here and did not know it. look into this
    # instead of 1,up - just 1, then I can see what the current floor is and I
    # determin if I need to go up or down

    # data = user_input.split(',')
    # cab.destination = data[0].to_i
    # if data[1].nil?
    #   user_input.to_i < cab.current_floor ? result = UserRequest.new(user_input.to_i, 'down') : result = UserRequest.new(user_input.to_i, 'up')
    # else
    #   result = UserRequest.new(data[0].to_i, data[1])
    # end

    user_input.to_i < cab.current_floor ? result = UserRequest.new(user_input.to_i, 'down') : result = UserRequest.new(user_input.to_i, 'up')
    result
  end
end
