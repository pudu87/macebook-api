# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_list = [
  'rocky@internet.com',
  'ivan@internet.com',
  'wagneau@internet.com',
  'damir@internet.com',
  'mama@internet.com',
  'jurgen@internet.com'
]

users_list.each do |e|
  new_user = User.create(email: e, password: 'password', password_confirmation: 'password')
end

friendships_list = [
  [1, 2, true],
  [1, 3, true],
  [1, 4, true],
  [1, 5, false],
  [2, 3, true],
  [2, 4, false]
]

friendships_list.each do |u,f,a|
  Friendship.find_or_create_by(user_id: u, friend_id: f, accepted: a)
end

posts_list = [
  [1, 'I scored a hattrick against Lokeren.'],
  [2, 'I won a silver medal in Russia 2018.'],
  [4, 'They call me the Bosnian Wizard.'],
  [6, "Please don't remind me of that own goal against Anderlecht."],
  [2, 'I played for Bayeren Munchen and Inter Milan, but my favourite team will always be Roeselare.']
]

posts_list.each do |u,c|
  Post.find_or_create_by(user_id: u, content: c)
end

comments_list = [
  [3, 1, 'I was there. Rocky I, Rocky II, Rocky III!'],
  [2, 1, 'We could use you in the Croatian team, Rocky.'],
  [1, 1, "I retired already, Ivan. But let me know if they need a trainer."],
  [3, 2, 'Well done, Ivan.'],
  [3, 2, 'One day we will win that cup with Haiti.']
]

comments_list.each do |u,pt,c|
  Comment.find_or_create_by(user_id: u, post_id: pt, content: c)
end

likes_list = [
  [1, 1],
  [1, 2],
  [1, 3],
  [2, 1],
  [2, 3],
  [5, 1]
]

likes_list.each do |u,pt|
  Like.find_or_create_by(user_id: u, post_id: pt)
end

profiles_list = [
  [1, 'Rocky', 'Peeters', Date.parse('18-08-1979'), 'M', 'Herentals'],
  [2, 'Ivan', 'Perisic', Date.parse('02-02-1989'), 'M', 'Munchen'],
  [3, 'Wagneau', 'Eloi', '', '', ''],
  [4, 'Damir', 'Mirvic', '', '', ''],
  [5, 'Mama', 'Dissa', '', '', ''],
  [6, 'Jurgen', 'Sierens', '', '', '']
]

profiles_list.each do |u,fn,ln,bd,s,l|
  User.find(u).profile.update(first_name: fn, last_name: ln, birthdate: bd, sex: s, location: l)
end
