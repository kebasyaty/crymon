require "./field"

module Crymon
  module Fields
    # This type was created specifically for the hash field.
    struct HashField < Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "HashField"
      # Html tag: input type="url".
      getter input_type : String = "text"
      # Sets the value of an element.
      property value : String | Nil
      # Value by default.
      property default : String | Nil
      # Displays prompt text.
      property placeholder : String
      # The maximum number of characters allowed in the text.
      property maxlength : UInt32
      # The minimum number of characters allowed in the text.
      property minlength : UInt32
      # The unique value of a field in a collection.
      property is_unique : Bool
      # Hide field from user.
      property is_hide : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # Hint: It is recommended not to change.
      getter group : UInt8 = 1

      def initialize(
        @label : String = "",
        @default : String | Nil = nil,
        @placeholder : String = "",
        @maxlength : UInt32 = 12,
        @minlength : UInt32 = 12,
        @is_hide : Bool = true,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = ""
      ); end
    end
  end
end