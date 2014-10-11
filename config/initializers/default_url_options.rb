if Rails.env.test?
  Rails.application.default_url_options = { host: 'test.host' }
else
  Rails.application.default_url_options = Rails.application.config.action_controller.default_url_options
end
