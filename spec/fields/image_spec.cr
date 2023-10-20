require "../spec_helper"

describe Fields do
  describe "Fields::ImageField" do
    describe ".new" do
      it "create an instance of the Image field" do
        f = Fields::ImageField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ImageField")
        f.input_type.should eq("file")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.media_root.should eq("../../assets/media")
        f.media_url.should eq("/media")
        f.target_dir.should eq("images")
        f.accept.should eq("")
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(9_u32)
      end
    end
  end
end
