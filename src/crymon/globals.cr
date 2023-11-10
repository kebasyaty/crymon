module Crymon
  module Globals
    # Global storage for metadata caching.
    class_getter store_metadata : Hash(String, Crymon::Globals::StoreMetaDataType) = Hash(String, Crymon::Globals::StoreMetaDataType).new
    # Global storage for Mongodb client caching.
    class_property store_mongo_client : Mongo::Client?
    # Global storage for super collection name caching.
    # <br>
    # <br>
    # Super collection is used for:
    # - _Store technical data for Models migration into a database._
    # - _Store dynamic field data for simulate relationship Many-to-One and Many-to-Manyю._
    class_getter store_super_collection_name : String = "SUPER_COLLECTION"
    # Global project settings.
    class_property store_settings : Crymon::Globals::StoreSettings?
    # Global storage for regex caching.
    class_getter store_regex : Crymon::Globals::StoreRegexType = NamedTuple.new(
      model_name: Regex.new("^[A-Z][a-zA-Z0-9]{0,24}$"),
      app_name: Regex.new("^[a-zA-Z][-_a-zA-Z0-9]{0,43}$"),
      unique_app_key: Regex.new("^[a-zA-Z0-9]{16}$"),
      service_name: Regex.new("^[A-Z][a-zA-Z0-9]{0,24}$"),
    )

    # All field types.
    alias FieldTypes = Crymon::Fields::URLField | Crymon::Fields::TextField |
                       Crymon::Fields::SlugField | Crymon::Fields::PhoneField |
                       Crymon::Fields::PasswordField | Crymon::Fields::U32Field |
                       Crymon::Fields::I64Field | Crymon::Fields::F64Field |
                       Crymon::Fields::IPField | Crymon::Fields::ImageField |
                       Crymon::Fields::HashField | Crymon::Fields::FileField |
                       Crymon::Fields::EmailField | Crymon::Fields::DateTimeField |
                       Crymon::Fields::DateField | Crymon::Fields::ColorField |
                       Crymon::Fields::ChoiceU32Field | Crymon::Fields::ChoiceU32MultField |
                       Crymon::Fields::ChoiceU32DynField | Crymon::Fields::ChoiceU32MultDynField |
                       Crymon::Fields::ChoiceTextField | Crymon::Fields::ChoiceTextMultField |
                       Crymon::Fields::ChoiceTextDynField | Crymon::Fields::ChoiceTextMultDynField |
                       Crymon::Fields::ChoiceI64Field | Crymon::Fields::ChoiceI64MultField |
                       Crymon::Fields::ChoiceI64DynField | Crymon::Fields::ChoiceI64MultDynField |
                       Crymon::Fields::ChoiceF64Field | Crymon::Fields::ChoiceF64MultField |
                       Crymon::Fields::ChoiceF64DynField | Crymon::Fields::ChoiceF64MultDynField |
                       Crymon::Fields::BoolField

    # Field value types.
    alias ValueTypes = String | UInt32 | Int64 | Float64 | Crymon::Fields::ImageData |
                       Crymon::Fields::FileData | Array(UInt32) | Array(String) | Array(Int64) |
                       Array(Float64) | Bool | Nil

    # Data types to select in dynamic fields.
    alias DataDynamicTypes = Array(String) | Array(UInt32) | Array(Int64) | Array(Float64) | Nil

    # A type for caching Metadata of Model.
    alias StoreMetaDataType = NamedTuple(
      model_name: String,
      service_name: String,
      collection_name: String,
      db_query_docs_limit: UInt32,
      field_count: Int32,
      field_name_list: Array(String),
      field_type_list: Array(String),
      field_name_and_type_list: Hash(String, String),
      default_value_list: Hash(String, Crymon::Globals::ValueTypes),
      is_add_doc: Bool,
      is_up_doc: Bool,
      is_del_doc: Bool,
      is_use_addition: Bool,
      is_use_hooks: Bool,
      is_use_hash_slug: Bool,
      ignore_fields: Array(String),
      field_attrs: Hash(String, NamedTuple(id: String, name: String)),
      data_dynamic_fields: Hash(String, Crymon::Globals::DataDynamicTypes),
    )

    # A type for caching regular expressions.
    alias StoreRegexType = NamedTuple(
      model_name: Regex,
      app_name: Regex,
      unique_app_key: Regex,
      service_name: Regex,
    )

    # Type for global project settings.
    struct StoreSettings
      getter app_name : String
      getter unique_app_key : String
      getter database_name : String?

      def initialize(
        @app_name : String,
        @unique_app_key : String,
        database_name : String? = nil
      )
        self.is_valid_app_name @app_name
        self.is_valid_unique_app_key @unique_app_key
        if database_name.nil?
          @database_name = "#{@app_name}_#{@unique_app_key}"
        else
          self.is_valid_database_name database_name
          @database_name = database_name
        end
      end

      # App name = Project name.
      # WARNING: Maximum 44 characters.
      # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/
      def is_valid_app_name(app_name : String)
        raise Crymon::Errors::StoreSettingsExcessChars.new(
          "app_name", 44
        ) if app_name.size > 44
        unless Crymon::Globals.store_regex[:app_name].matches?(app_name)
          raise Crymon::Errors::StoreSettingsRegexFails.new(
            "app_name",
            "/^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/"
          )
        end
      end

      # Unique project key.
      # WARNING: Match regular expression: /^[a-zA-Z0-9]{16}$/
      def is_valid_unique_app_key(unique_app_key : String)
        unless Crymon::Globals.store_regex[:unique_app_key].matches?(unique_app_key)
          raise Crymon::Errors::StoreSettingsRegexFails.new(
            "unique_app_key",
            "/^[a-zA-Z0-9]{16}$/"
          )
        end
      end

      # Database name.
      # WARNING: Maximum 60 characters.
      def is_valid_database_name(database_name : String)
        raise Crymon::Errors::StoreSettingsExcessChars.new(
          "database_name", 60
        ) if database_name.size > 60
      end
    end
  end
end
