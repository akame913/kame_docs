# encoding: utf-8

require 'spec_helper'


describe Document do
  before do
    @document = Document.new(name: "Example Document", description: "yyyy",
                     data: "this is data", content_type: "text.abc.txt" )
  end

  subject { @document }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:data) }  
  it { should respond_to(:content_type) }  
  
  it { should be_valid }

  describe "when name is not present" do
    before { @document.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @document.description = " " }
    it { should_not be_valid }
  end

  #describe "when data is not present" do
  #  before { @document.data = " " }
  #  it { should_not be_valid }
  #end

  #describe "when content_type is not present" do
  #  before { @document.content_type = " " }
  #  it { should_not be_valid }
  #end

  #describe "when name is already taken" do
  #  before do
  #    document_with_same_name = @document.dup
  #    document_with_same_name.save
  #  end
  #  it { should_not be_valid }
  #end

end
