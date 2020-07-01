require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nyanstagram
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.paths.add 'lib', eager_load: true
    #　以下の記述を追記する(設定必須)
    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    config.encoding = "utf-8"

  end
end
