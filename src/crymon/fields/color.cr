require "./field"

module Crymon
  module Fields
    # Field for entering color.
    # The default value is #000000 (black).
    # By default type="text".
    # WARNING: type="color" only seven-character hexadecimal notation.
    # Examples: #fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) |
    # rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff.
    struct ColorField < Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ColorField"
      # Html tag: input type="color".
      # By default type="text".
      # WARNING: type="color" only seven-character hexadecimal notation.
      getter input_type : String
      # Sets the value of an element.
      property value : String | Nil
      # The default value is #000000.
      property default : String | Nil
      # Displays prompt text.
      property placeholder : String
      # The maximum number of characters allowed in the text.
      property maxlength : UInt32
      # The minimum number of characters allowed in the text.
      property minlength : UInt32
      # The unique value of a field in a collection.
      property is_unique : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # Hint: It is recommended not to change.
      getter group : UInt8 = 1

      def initialize(
        @label : String = "",
        @default : String | Nil = "#000000",
        @input_type : String = "text", # text | color
        @placeholder : String = "",
        @maxlength : UInt32 = 256,
        @minlength : UInt32 = 0,
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = ""
      )
        if ["text", "color"].index(@input_type).nil?
          raise Crymon::Errors::InvalidInputType.new(@input_type)
        end
      end
    end
  end
end