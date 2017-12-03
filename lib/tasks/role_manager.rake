namespace :role_manager do
  desc "TODO"
  task build_roles: :environment do
    ['user', 'banned', 'moderator', 'admin'].each_with_index do |role, index|
      Role.find_or_create_by({name: role, resource_id: index})
    end
  end

end
