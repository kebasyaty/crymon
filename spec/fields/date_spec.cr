require "../spec_helper"

describe Fields do
  describe "Fields::DateField" do
    describe ".new" do
      it "create an instance of the Date field" do
        f = Fields::DateField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("DateField")
        f.input_type.should eq("date")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.max.should eq("")
        f.min.should eq("")
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("Format: yyyy-mm-dd")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(3_u32)
      end
    end
  end
end