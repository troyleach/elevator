class Floor
  # contract {:number_of_floors}
  def initialize(*args)
    @floor = nil
    @top_floor = args[0]
  end

  def lobby?
    floor == 1
  end

  def top?
    floor == top_floor
  end
end
