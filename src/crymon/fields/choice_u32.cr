require "./field"

module Crymon::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  struct ChoiceU32Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32Field"
    # Sets the value of an element.
    property value : UInt32?
    # Value by default.
    getter default : UInt32?
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
    #
    # Stubs
    getter max : Nil
    getter min : Nil

    def initialize(
      @label : String = "",
      @default : UInt32? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  struct ChoiceU32MultField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32MultField"
    # Sets the value of an element.
    property value : Array(UInt32)?
    # Value by default.
    getter default : Array(UInt32)?
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # Html tag: select multiple.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 6
    #
    # Stubs
    getter max : Nil
    getter min : Nil

    def initialize(
      @label : String = "",
      @default : Array(UInt32) | Nil = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-One.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceU32DynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32DynField"
    # Sets the value of an element.
    property value : UInt32?
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 5
    #
    # Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end

    # To work around the error - undefined method 'choices='.
    def set_choices(json : String)
      @choices = Array(Tuple(UInt32, String)).from_json(json)
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceU32MultDynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32MultDynField"
    # Sets the value of an element.
    property value : Array(UInt32)?
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 7
    #
    # Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end

    # To work around the error - undefined method 'choices='.
    def set_choices(json : String)
      @choices = Array(Tuple(UInt32, String)).from_json(json)
    end
  end
end
