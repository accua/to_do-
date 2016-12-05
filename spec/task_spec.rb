require('rspec')
require('task')
require('pg')

DB = PG.connect({:dbname => 'todo_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  before(:each) do

  end
  describe(":==") do
    it('is the same task if it has the same description') do
      task1 = Task.new({:description => "learn SQL"})
      task2 = Task.new({:description => "learn SQL"})
      expect(task1).to eq task2
    end
  end

  describe("#initialize") do
    it('will initialize tasks properly') do

    end
  end
end
