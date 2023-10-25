require "./field"

module Crymon
  module Fields
    # File upload field.
    struct FileField < Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "FileField"
      # Html tag: input type="url".
      getter input_type : String = "file"
      # Sets the value of an element.
      property value : Fields::FileData | Nil
      # Value by default.
      property default : Fields::FileData | Nil
      # Root directory for storing media files.
      property media_root : String
      # URL address for the media directory.
      property media_url : String
      # Directory for files inside media directory (inner path).
      # Example: "files/resume".
      property target_dir : String
      # HTML attribute: accept
      # Describing which file types to allow.
      # Example: "image/jpeg,image/png,image/gif"
      # https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
      property accept : String = ""
      # Displays prompt text.
      property placeholder : String
      # The unique value of a field in a collection.
      property is_unique : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # Hint: It is recommended not to change.
      getter group : UInt8 = 8

      def initialize(
        @label : String = "",
        @default : Fields::FileData | Nil = nil,
        @media_root : String = "../assets/media",
        @media_url : String = "/media",
        @target_dir : String = "files",
        @accept : String = "",
        @placeholder : String = "",
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "",
        @warning : String = ""
      ); end
    end
  end
end