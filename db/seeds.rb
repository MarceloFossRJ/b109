# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Parameter.create(:group => 'user_interface', :name => 'records_per_page', :value => '10')
Parameter.create(:group => 'comments', :name => 'users_can_add_comment', :value => 'true')
Parameter.create(:group => 'comments', :name => 'comments_published_automatically', :value => 'false', :description => '.')
Parameter.create(:group => 'authentication', :name => 'linkedin_authentication', :value => 'true', :description => '.')
Parameter.create(:group => 'authentication', :name => 'github_authentication', :value => 'true', :description => '.')
Parameter.create(:group => 'authentication', :name => 'facebook_authentication', :value => 'true', :description => '.')
Parameter.create(:group => 'authentication', :name => 'gmail_authentication', :value => 'true', :description => '.')
Parameter.create(:group => 'application', :name => 'application_title', :value => 'F055', :description => '.')
Parameter.create(:group => 'application', :name => 'root_page', :value => 'home', :description => '.')
Parameter.create(:group => 'user_interface', :name => 'posts_per_page', :value => '3', :description => '.')

#Parameter.create (group: '', name: '', value: '', description: '')


