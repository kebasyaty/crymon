require "spec"
require "../src/crymon"

# Global project settings.
Crymon::Globals.store_settings = {
  app_name:       :AppName,
  unique_app_key: :RT0839370A074kVh,
  database_name:  :DatabaseName360,
}

# Parameters for Model.
module Settings
  APP_NAME       = "AppName"
  UNIQUE_APP_KEY = "RT0839370A074kVh"
  SERVICE_NAME   = "ServiceName"
end

module Helper
  # Model without variables and methods.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME
  )]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, db_query_docs_limit: 2000_u32,
    ignore_fields: ["age", "birthday"]
  )]
  struct FilledModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new("default": "Cat")
    getter age = Crymon::Fields::U32Field.new("default": 0)
    getter birthday = Crymon::Fields::DateField.new("default": "0000-00-00")
  end

  # Model with a predefined database name.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, database_name: "DatabaseName360"
  )]
  struct ParamDBNameModel < Crymon::Model
    getter name = Crymon::Fields::TextField.new
  end

  # Model without the required 'app_name' parameter for metadata.
  @[Crymon::Meta(
    unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME
  )]
  struct NoParamAppNameModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end

  # Model without the required 'unique_app_key' parameter for metadata.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME,
    service_name: Settings::SERVICE_NAME
  )]
  struct NoParamUniqueAppKeyModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end

  # Model without the required 'service_name' parameter for metadata.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME,
    unique_app_key: Settings::UNIQUE_APP_KEY
  )]
  struct NoParamServiceMameModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end

  # Incorrect field names in the ignored list.
  @[Crymon::Meta(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, db_query_docs_limit: 2000_u32,
    ignore_fields: ["age", "birthday"]
  )]
  struct IncorrectIgnoredListModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end
end
