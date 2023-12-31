require "./field"

module Crymon::Fields
  # A field for entering a text string.
  struct TextField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "TextField"
    # Html tag: input type="text".
    getter input_type : String = "text"
    # For Html textarea.
    getter? is_textarea : Bool
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : Int32?
    # The minimum number of characters allowed in the text.
    getter minlength : Int32?
    # Regular expression to validate the `value`.
    getter regex : String?
    # Error message.
    getter regex_err_msg : String?
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # WARNING: Stubs
    getter max : Nil
    getter min : Nil

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : Int32? = 256,
      @minlength : Int32? = 0,
      @regex : String? = nil,
      @regex_err_msg : String? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_textarea : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = ""
    ); end
  end
end
