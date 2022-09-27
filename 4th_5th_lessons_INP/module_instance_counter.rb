module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    @instance || 0

  end

  module InstanceMethods
    def register_instance
      self.class.instance += 1
    end
  end

end
