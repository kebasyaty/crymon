module DynFork::Paladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
  # | "TextField" | "HashField" | "URLField" | "IPField"_
  #
  def group_01(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool,
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
    # When updating, we skip field password type.
    if updated? && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return
    end
    # Get current value.
    current_value : String = (
      value : DynFork::Globals::ValueTypes = field_ptr.value.value || field_ptr.value.default
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil? || value.to_s.empty?
        if field_ptr.value.required?
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            error_symptom_ptr?
          )
        end
        (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
        return
      end
      value.to_s
    )
    # Validation the `regex` field attribute.
    if pattern = field_ptr.value.regex
      unless /#{pattern}/.matches?(current_value)
        self.accumulate_error(
          field_ptr.value.regex_err_msg.to_s,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `maxlength` field attribute.
    if maxlength = field_ptr.value.maxlength
      if current_value.size > maxlength
        err_msg = I18n.t(
          "number_not_greater_max.interpolation",
          curr_num: current_value.size,
          max_num: maxlength
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `minlength` field attribute.
    if minlength = field_ptr.value.minlength
      if current_value.size < minlength
        err_msg = I18n.t(
          "number_not_less_min.interpolation",
          curr_num: current_value.size,
          min_num: minlength
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `unique` field attribute.
    if field_ptr.value.unique? &&
       !collection_ptr.value.find_one({field_ptr.value.name => current_value}).nil?
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Validation Email, Url, IP, Color.
    case field_ptr.value.field_type
    when "EmailField"
      unless Valid.email? current_value
        self.accumulate_error(
          I18n.t(:invalid_email),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "URLField"
      unless Valid.url? current_value
        self.accumulate_error(
          I18n.t(:invalid_url),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "IPField"
      unless Valid.ip? current_value
        self.accumulate_error(
          I18n.t(:invalid_ip),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "ColorField"
      unless Valid.color? current_value
        self.accumulate_error(
          I18n.t(:invalid_color),
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Insert result.
    if save?
      if field_ptr.value.field_type == "PasswordField"
        current_value = Crypto::Bcrypt::Password.create(current_value).to_s
      end
      result_bson_ptr.value[field_ptr.value.name] = current_value
    end
  end
end