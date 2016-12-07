require('sinatra')
require('sinatra/reloader')
require('pg')
require('./lib/task')
require('./lib/list')
also_reload('lib/**/*.rb')

if ENV['DATABASE_URL']
  DB = PG.connect(ENV['DATABASE_URL'])
else
  DB = PG.connect({:dbname => 'to_do_test'})
end

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new(:name => name, :id => nil)
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id/tasks") do
  @list = List.find(params.fetch("id").to_i)
  erb(:list)
end

post("/list/:id/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i
  @list = List.find(list_id)
  @task = Task.new(:description => description, :list_id => list_id)
  @task.save
  erb(:list)
end

get("/method") do
  DB.exec("DELETE FROM tasks *;")
  DB.exec("DELETE FROM lists *;")
  redirect "/"
end
