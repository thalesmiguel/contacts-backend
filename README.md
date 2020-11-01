# contacts-backend

### Summary
Backend service to handle a list of contacts.
Uses `ruby 2.7.2` and `rails 6.0.3`.

### How to run
#### On your own
1. `git clone`
2. `cd into directory`
3. `bundle`
4. `rake db:create && rake db:migrate`
5. `rails s`

#### With Docker
1. `git clone`
2. `cd into directory`
3. `docker-compose build`
4. `docker-compose run web bundle exec rails db:create`
5. `docker-compose run web bundle exec rails db:migrate`
6. `docker-compose up --build`


### Run tests
`rspec`

### To-do
1. Add search and pagination to Contacts#index
2. Add pagination to Contacts#history
3. Add a real database
4. Add rake task + cronjob to remove old history versions
5. Experiment with ActionCable
