if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.root = "#{Rails.root}/tmp"
    config.storage = :file
    config.asset_host = ActionController::Base.asset_host
  end
end