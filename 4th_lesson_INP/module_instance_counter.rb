module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      # self.class.instance_count
    end

  end

  module InstanceMethods
    def register_instance(instance_count)
      instance_count += 1
      instance_count
    end
  end

end
