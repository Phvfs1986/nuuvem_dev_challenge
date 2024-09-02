class ApplicationSerializer
  class << self
    def attributes(*args)
      @attributes ||= {}

      args.each do |arg|
        if arg.is_a?(Hash)
          arg.each { |attribute, label| @attributes[attribute] = label }
        else
          @attributes[arg] = arg.to_s.humanize
        end
      end
    end

    def get_attributes
      @attributes.keys
    end

    def get_labels
      @attributes.values
    end

    def attributes_with_labels
      @attributes
    end
  end

  def attributes
    self.class.get_attributes
  end

  def labels
    self.class.get_labels
  end

  def attributes_with_labels
    self.class.attributes_with_labels
  end
end
