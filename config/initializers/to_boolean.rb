module ToBoolean
  def to_bool
    return true if self == true || self.to_s.strip =~ /^(true|yes|y|1)$/i
    return false
  end
end

class FalseClass; include ToBoolean; end
class NilClass;   include ToBoolean; end
class Numeric;    include ToBoolean; end
class String;     include ToBoolean; end
class TrueClass;  include ToBoolean; end