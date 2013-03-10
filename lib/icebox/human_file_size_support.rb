class Fixnum

  def bytes
    self
  end

  def kilobytes
    bytes * 1024
  end
  alias :KB :kilobytes

  def megabytes
    kilobytes * 1024
  end
  alias :MB :megabytes

end
