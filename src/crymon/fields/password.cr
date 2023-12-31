require "./field"

module Crymon::Fields
  # Field for entering password.
  struct PasswordField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "PasswordField"
    # Html tag: input type="url".
    getter input_type : String = "password"
    # Sets the value of an element.
    property value : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : Int32
    # The minimum number of characters allowed in the text.
    getter minlength : Int32
    # Regular expression to validate the value.
    getter regex : String?
    # Error message.
    getter regex_err_msg : String?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # WARNING: Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil
    getter? is_unique : Bool = false

    def initialize(
      @label : String = "",
      @placeholder : String = "",
      @maxlength : Int32 = 256,
      @minlength : Int32 = 8,
      @regex : String? = "^[a-zA-Z0-9@#$%^&+=*!~)(]{8,256}$",
      @regex_err_msg : String? = I18n.t("allowed_chars.interpolation", chars: "a-z A-Z 0-9 @ # $ % ^ & + = * ! ~ ) ("),
      @is_hide : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end
