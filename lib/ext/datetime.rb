class DateTime

  def to_json(*args)
    iso8601(6).to_json(*args)
  end

end
