puts 'Start db:seed task'

admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', username: 'admin')
user1 = User.create!(email: 'user1@example.com', password: 'password', password_confirmation: 'password', username: 'user1')
user2 = User.create!(email: 'user2@example.com', password: 'password', password_confirmation: 'password', username: 'user2')
user3 = User.create!(email: 'user3@example.com', password: 'password', password_confirmation: 'password', username: 'user3')
user4 = User.create!(email: 'user4@example.com', password: 'password', password_confirmation: 'password', username: 'user4')
user5 = User.create!(email: 'user5@example.com', password: 'password', password_confirmation: 'password', username: 'user5')
user6 = User.create!(email: 'user6@example.com', password: 'password', password_confirmation: 'password', username: 'user6')

#Topics
topic1 = Topic.create!(title: 'You can try to clear browser cache and restart the browser.', text: 'I think what may have happened is previously you were hosting a site at localhost:3000 which was served over SSL (or maybe had HSTS enabled). Your browser is attempting to open a connection to localhost:3000 over SSL because of that.', author: user1)
topic2 = Topic.create!(title: 'You can try to clear browser cache(or history) and restart the browser.', text: 'I think what may have happened is previously you were hosting a site at localhost:3001 which was served over SSL (or maybe had HSTS enabled). Your browser is attempting to open a connection to localhost:3000 over SSL because of that.', author: user2)
topic3 = Topic.create!(title: 'You can try to clear browser cache(or history) and restart the browser', text: 'I think what may have happened is previously you were hosting a site at localhost:3002 which was served over SSL (or maybe had HSTS enabled). Your browser is attempting to open a connection to localhost:3000 over SSL because of that.', author: user3)
topic4 = Topic.create!(title: 'You can try to clear browser cache(or history) and restart the browser...', text: 'I think what may have happened is previously you were hosting a site at localhost:3003 which was served over SSL (or maybe had HSTS enabled). Your browser is attempting to open a connection to localhost:3000 over SSL because of that.', author: user4)
topic5 = Topic.create!(title: 'You can try to clear browser cache(or history) and restart the browser..', text: 'I think what may have happened is previously you were hosting a site at localhost:3004 which was served over SSL (or maybe had HSTS enabled). Your browser is attempting to open a connection to localhost:3000 over SSL because of that.', author: user5)


#Events
event1 = Event.create!(title: 'RubyC 2017', text: 'RubyC is the major Ukrainian conference devoted to Ruby, Rails and related technologies. Organized annually by Svitla Systems, RubyC gathers hundreds of Ruby enthusiasts from all over the world to discuss latest news and spend beautiful summer weekend in Kyiv.', author: admin, start_time: Faker::Time.backward, end_time: Faker::Time.forward, city: Faker::Address.city, address: Faker::Address.street_address)
event2 = Event.create!(title: 'Joker 2k16', text: 'We focus on people who are already well familiar with Java. Comprehensive and technically sophisticated sessions guarantee a high level of competence of our audience.', author: admin, start_time: Faker::Time.backward, end_time: Faker::Time.forward, city: Faker::Address.city, address: Faker::Address.street_address)
event3 = Event.create!(title: 'Holly.js', text: 'The JavaScript conference HolyJS 2017 Piter took place on June 2-3, 2017, and brought together over 400 JS developers. It was the third HolyJS.', author: admin, start_time: Faker::Time.backward, end_time: Faker::Time.forward, city: Faker::Address.city, address: Faker::Address.street_address)
event4 = Event.create!(title: 'JSConf', text: "JSConf is a unique conference organization, because we aren't really a conference organization at all. We are a very loose federation of developers who share the same general idea about how a technical conference should be held. We don't believe that one model or process fits all communities, in fact we are big advocates of locally run events driven by passionate individuals dedicated to the community", author: admin, start_time: Faker::Time.backward, end_time: Faker::Time.forward, city: Faker::Address.city, address: Faker::Address.street_address)
event5 = Event.create!(title: 'RedisConf 2017', text: 'RedisConf 2017 is a wrap and we’re looking forward to RedisConf 2018! Sincere thanks to everyone who made this event such a success! Let’s stay in touch! Click here and sign-up to receive the latest news and updates surrounding RedisConf 2018.', author: admin, start_time: Faker::Time.backward, end_time: Faker::Time.forward, city: Faker::Address.city, address: Faker::Address.street_address)

puts 'End db:seed task'
