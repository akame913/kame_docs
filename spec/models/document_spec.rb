# encoding: utf-8

require 'spec_helper'


describe Document do
  let(:user) { FactoryGirl.create(:user) }

  before do
    #@document = Document.new(name: "Example Document", description: "yyyy",
    #                 data: "this is data", content_type: "text.abc.txt" )
    @document = user.documents.build(name: "Example Document", 
                     description: "yyyy",
                     data: "this is data", 
                     content_type: "text.abc.txt" )

  end

  subject { @document }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:data) }  
  it { should respond_to(:content_type) }  
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @document.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @document.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @document.description = " " }
    it { should_not be_valid }
  end

end
