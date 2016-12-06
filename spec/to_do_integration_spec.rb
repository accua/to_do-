require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it("allows the user to create a new list") do
    visit('/')
    fill_in("name", :with => 'Epicodus Work')
    click_button('Add List')
    expect(page).to have_content('Epicodus Work')
  end
end

describe('seeing the tasks for a single list', {:type => :feature}) do
  it('allows a user to click on a task list and see the tasks on the list') do
    test_list = List.new(:name => "School stuff")
    test_list.save()
    test_task = Task.new(:description => "Learn SQL", :list_id => test_list.id)
    visit('/')
    click_link(test_list.name)
    expect(page).to have_content(test_task.description)
  end
end

describe('adding tasks to a list', {:type => :feature}) do
  it('allows a user to add a task to a list')
    test_list = List.new(:name => "Epicodus Work")
    test_list.save
    visit('/lists/#{test_list.id}')
    fill_in("description", :with => "Learn SQL")
    click_button('Add Task')
    expect(page).to have_content("Learn SQL")
end
