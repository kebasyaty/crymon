require "./field"

module DynFork::Fields
  # A field for entering a text string.
  struct TextField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "TextField"
    # Html tag: input type="text".
    getter input_type : String = "text"
    # For Html textarea.
    getter? textarea : Bool
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : UInt32?
    # The minimum number of characters allowed in the text.
    getter minlength : UInt32?
    # Regular expression to validate the `value`.
    getter regex : String?
    # Error message.
    getter regex_err_msg : String?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter choices : Nil
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    def has_value?; end

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : UInt32? = 256,
      @minlength : UInt32? = 0,
      @regex : String? = nil,
      @regex_err_msg : String? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @textarea : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    ); end
  end
end