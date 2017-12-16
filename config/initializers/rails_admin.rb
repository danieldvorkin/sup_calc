RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.authorize_with do |controller|
    if current_user.nil?
      redirect_to main_app.new_account_session_path, flash: {error: 'Please Login to Continue..'}
    elsif !current_user.has_role? "admin"
      redirect_to main_app.root_path, flash: {error: 'You are not Admin bro!'}
    end
  end
  
  config.model 'SystemStat' do
    list do
      field :completion_time
      field :status
      field :created_at
      field :products_added
      field :products_updated
    end
  end
  
  config.model 'Order' do
    list do
      field :id
      field :subtotal
      field :order_status
      field :user
    end
  end
  
  config.model 'Product' do
    list do
      field :id
      field :title
      field :price
      field :dropweek
      field :filter
      field :hype
      field :hype_price
    end
  end
  
  config.model 'User' do
    list do
      field :id
      field :email
      field :sign_in_count
      field :orders
    end
  end
  
  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
