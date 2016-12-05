class Task
  attr_reader :description
  define_method(:initialize) do |attrs|
    @description = attrs.fetch(:description)
  end
  define_method(:==) do |other|
    self.description.eql? other.description
  end

end
