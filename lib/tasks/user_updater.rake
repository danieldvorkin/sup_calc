namespace :user_updater do
  desc "TODO"
  task update_roles: :environment do
    users = User.all
    if user.roles.empty?
      user.add_role "user"
    elsif user.has_role? "admin"
      next
    end
  end

end
