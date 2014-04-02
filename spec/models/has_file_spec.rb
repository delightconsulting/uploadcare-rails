require "spec_helper"

describe :has_uploadcare_file do
  before(:all) do
    @uploaded = UPLOADCARE_SETTINGS.api.upload 'http://www.gametech.ru/sadm_images/00jin/2014/march/10/21-03-2014%207-58-17.jpg'
    @cdn_url = @uploaded.cdn_url
  end

  before(:each) do
    @post = Post.new title: "Post title", file: @cdn_url 
    @method = "file"
  end

  it "should respond to has_uploadcare_file? method" do
    @post.should respond_to("has_#{@method}_as_uploadcare_file?".to_sym)
  end

  it "should respond to has_uploadcare_group? method" do
    @post.should respond_to("has_#{@method}_as_uploadcare_group?".to_sym)
  end

  it ":has_uploadcare_file? should return true" do
    @post.has_file_as_uploadcare_file?.should == true
  end

  it ":has_uploadcare_group? should return false" do
    @post.has_file_as_uploadcare_group?.should == false
  end

  it "should have uploadcare file" do
    @post.file.should be_kind_of(Uploadcare::Rails::File)
  end

  it "file should not be loaded by default" do
    @post.file.loaded?.should == false
  end
end