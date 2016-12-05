class Task
  attr_reader :description

  define_method(:initialize) do |attrs|
    @description = attrs.fetch(:description)
  end

  define_method(:==) do |other|
    self.description.eql? other.description
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      tasks.push(Task.new({:description => description}))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}')")
    # DB.exec("INSERT INTO tasks (description) VALUES ('pet cat')")
  end
end
