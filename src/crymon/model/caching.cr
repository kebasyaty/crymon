# For caching Model metadata.
module Crymon::Caching
  # Add metadata to the global store.
  def caching(model_key : String)
    # Check the model for the presence of variables (fields).
    {% if @type.instance_vars.size < 4 %}
        # If there are no fields in the model, a FieldsMissing exception is raise.
        raise Crymon::Errors::ModelFieldsMissing.new({{ @type.name.stringify }}.split("::").last)
      {% end %}
    # Get Model name = Structure name.
    # <br>
    # _**Examples:** User | UserProfile | ElectricCar | etc ..._
    # WARNING: Maximum 25 characters.
    model_name : String = {{ @type.name.stringify }}.split("::").last
    raise Crymon::Errors::ModelNameExcessChars.new(model_name) if model_name.size > 25
    unless Crymon::Globals.cache_regex[:model_name].matches?(model_name)
      raise Crymon::Errors::ModelNameRegexFails.new(model_name, "/^[A-Z][a-zA-Z0-9]{0,24}$/")
    end
    # Get Service name = Module name.
    # <br>
    # _**Examples:** Accounts | Smartphones | Washing machines | etc ..._
    # WARNING: Maximum 25 characters.
    service_name : String = {{ @type.annotation(Crymon::Meta)[:service_name] }} ||
      raise Crymon::Errors::MetaParameterMissing.new(model_name, "service_name")
    raise Crymon::Errors::MetaParamExcessChars
      .new(model_name, "service_name", 25) if service_name.size > 25
    unless Crymon::Globals.cache_regex[:service_name].matches?(service_name)
      raise Crymon::Errors::MetaParamRegexFails
        .new(model_name, "service_name", "/^[A-Z][a-zA-Z0-9]{0,24}$/")
    end
    # Get collection name.
    # WARNING: Maximum 50 characters.
    collection_name : String = "#{service_name}_#{model_name}"
    # Get list of names and types of variables (fields).
    # <br>
    # _**Format:** <field_name, field_type>_
    field_name_and_type_list : Hash(String, String) = (
      {% if @type.instance_vars.size > 3 %}
          Hash.zip(
            {{ @type.instance_vars.map &.name.stringify }},
            {{ @type.instance_vars.map &.type.stringify }}
              .map { |name| name.split("::").last }
          )
        {% else %}
        Hash(String, String).new
      {% end %}
    )
    # Get default value list.
    # <br>
    # _**Format:** <field_name, default_value>_
    default_value_list : Hash(String, Crymon::Globals::ValueTypes) = (
      {% if @type.instance_vars.size > 3 %}
        hash = Hash(String, Crymon::Globals::ValueTypes).new
        self.field_name_and_value_list.each do |key, value|
          hash[key] = value.default
        end
        hash
      {% else %}
        Hash(String, Crymon::Globals::ValueTypes).new
      {% end %}
    )
    # Does a field of type SlugField use a hash field as its source?
    is_use_hash_slug : Bool = (
      flag : Bool = false
      field_name_list : Array(String) = field_name_and_type_list.keys
      {% for var in @type.instance_vars %}
          if @{{ var }}.field_type == "SlugField"
            @{{ var }}.get_slug_sources.each do |source_name|
              unless field_name_list.includes?(source_name)
                raise Crymon::Errors::SlugSourceInvalid.new(model_name, {{ var.name.stringify }}, source_name)
              end
            end
            if !flag && @{{ var }}.get_slug_sources.includes?("hash")
              flag = true
            end
          end
        {% end %}
      flag
    )
    # Get list of field names that will not be saved to the database.
    ignore_fields : Array(String) = (
      f_list = Array(String).new
      {% for var in @type.instance_vars %}
          if @{{ var }}.is_ignored
            f_list << {{ var.name.stringify }}
          end
        {% end %}
      f_list
    )
    # Get attributes value for fields of Model: id, name.
    field_attrs : Hash(String, NamedTuple(id: String, name: String)) = (
      hash = Hash(String, NamedTuple(id: String, name: String)).new
      {% for var in @type.instance_vars %}
          hash[{{ var.name.stringify }}] = {
            id: "#{{{ @type.name.stringify }}.split("::").last}--#{{{ var.name.stringify }}.gsub("_", "-")}",
            name: {{ var.name.stringify }}
          }
        {% end %}
      hash
    )
    #
    # Add metadata to the global store.
    Crymon::Globals.cache_metadata[model_key] = {
      # Model name = Structure name.
      model_name: model_name,
      # Service Name = Application subsection = Module name.
      service_name: service_name,
      # Collection name.
      collection_name: collection_name,
      # limiting query results.
      db_query_docs_limit: {{ @type.annotation(Crymon::Meta)[:db_query_docs_limit] }} || 1000_u32,
      # Number of variables (fields).
      field_count: {{ @type.instance_vars.size }},
      # List of names and types of variables (fields).
      # <br>
      # _**Format:** <field_name, field_type>_
      field_name_and_type_list: field_name_and_type_list,
      # Default value list.
      # <br>
      # _**Format:** <field_name, default_value>_
      default_value_list: default_value_list,
      # Create documents in the database. By default = true.
      # NOTE: false - Alternatively, use it to validate data from web forms.
      is_add_doc: {{ @type.annotation(Crymon::Meta)[:is_add_doc] }} || true,
      # Update documents in the database.
      is_up_doc: {{ @type.annotation(Crymon::Meta)[:is_up_doc] }} || true,
      # Delete documents from the database.
      is_del_doc: {{ @type.annotation(Crymon::Meta)[:is_del_doc] }} || true,
      # Does a field of type SlugField use a hash field as its source?
      is_use_hash_slug: is_use_hash_slug,
      # List of field names that will not be saved to the database.
      ignore_fields: ignore_fields,
      # Attributes value for fields of Model: id, name.
      field_attrs: field_attrs,
      # Data for dynamic fields.
      data_dynamic_fields: Hash(String, String).new,
    }
  end
end