class Float
  def approx(other, epsilon=Float::EPSILON)
    return( other - self ).abs <= epsilon
  end
end
