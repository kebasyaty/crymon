require "./field"

module DynFork::Fields
  # File upload field.
  struct FileField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "FileField"
    # Html tag: input type="url".
    getter input_type : String = "file"
    # Sets the value of an element.
    property value : DynFork::Globals::FileData?
    # Default file path.
    # <br>
    # _Example: "assets/media/default/nodoc.docx"_
    getter default : String?
    # Root directory for storing media files.
    getter media_root : String
    # URL address for the media directory.
    getter media_url : String
    # Directory for files inside media directory (inner path).
    # <br>
    # _Example: "files/resume"_
    getter target_dir : String
    # HTML attribute: accept
    # <br>
    # Describing which file types to allow.
    # <br>
    # _Example: ".pdf,.doc,.docx,application/msword"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = ""
    # Displays prompt text.
    getter placeholder : String
    # The maximum allowed file size in megabytes.
    getter maxsize : Float32
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
    #
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter regex : Nil
    # :nodoc:
    getter regex_err_msg : Nil
    # :nodoc:
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter choices : Nil

    # :nodoc:
    def has_value?; end

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @media_root : String = "assets/media",
      @media_url : String = "/media",
      @target_dir : String = "files",
      @accept : String = "",
      @placeholder : String = "",
      @maxsize : Float32 = 0.5,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end