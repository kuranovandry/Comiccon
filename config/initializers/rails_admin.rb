RailsAdmin.config do |config|

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_user)

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
    nestable
  end

  config.navigation_static_label = "My Links"
  config.navigation_static_links = {
    'Calendar' => '/calendar'
  }

  RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
    config.current_user_method &:current_user
  end

  # RailsAdmin.config do |config|
  # config.authenticate_with do
  #   warden.authenticate! scope: :admin
  # end
  #   config.current_user_method &:current_admin
  # end
end