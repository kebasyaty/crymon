require "../../spec_helper"

describe Crymon::Fields::DateField do
  describe ".new" do
    it "=> create instance of Date field", tags: "fields" do
      f = Crymon::Fields::DateField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("DateField")
      f.input_type.should eq("date")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.get_time_object.should be_nil
      f.placeholder.should eq("")
      f.is_disabled?.should be_false
      f.is_readonly?.should be_false
      f.is_hide?.should be_false
      f.is_required?.should be_false
      f.is_unique?.should be_false
      f.is_ignored?.should be_false
      f.max.should be_nil
      f.min.should be_nil
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("Formats: dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy | yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
