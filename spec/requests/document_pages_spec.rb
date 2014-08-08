# encoding: utf-8

require 'spec_helper'

describe "Document Pages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit documents_path
    end

    it { should have_title('All documents') }
    it { should have_content('All documents') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:document) } }
      after(:all)  { Document.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each document" do
        Document.paginate(page: 1).each do |document|
          expect(page).to have_selector('h3', text: document.name)
        end
      end
    end
  end

  describe "document page" do
    let(:document) { FactoryGirl.create(:document) }
    before { visit document_path(document) }

    it { should have_content(document.name) }
    it { should have_title(document.name) }
  end
  
  describe "Upload document" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit new_document_path
    end
    
    it { should have_content("Upload document") }
    it { should have_title(full_title("Upload document")) }    
  end

  describe "upload" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit new_document_path
    end

    let(:submit) { "Upload file" }

    describe "with invalid information" do
      it "should not create a document" do
        expect { click_button submit }.not_to change(Document, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Upload  document') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        select  "GROUP1",       from: "document_group"
        fill_in "Description",  with: "Example description"
        attach_file "Uploaded document", "#{Rails.root}/spec/kame.gif"
      end

      it "should create a document" do
        expect { click_button submit }.to change(Document, :count).by(1)
      end

      describe "after saving the document" do
        before { click_button submit }
        let(:document) { Document.find_by(name: 'kame.gif') }

        it { should have_title(document.name) }
        it { should have_selector('div.alert.alert-success', text: 'sucess!') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:document) { FactoryGirl.create(:document) }
    before do
      sign_in user
      visit edit_document_path(document)
    end

    describe "page" do
      it { should have_content("Update document") }
      it { should have_title("Edit document") }
    end

    describe "with invalid information" do
      let(:blank_description)  { " " }
      before do
        fill_in "Description",  with: blank_description
        click_button "Save changes"
      end
      
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_description)  { "New description" }
      before do
        select  "GROUP2",       from: "document_group"
        fill_in "Description",  with: new_description
        click_button "Save changes"
      end

      it { should have_selector('div.alert.alert-success') }
      specify { expect(document.reload.group).to  eq "group-2" }
      specify { expect(document.reload.description).to  eq new_description }
    end
  end
end
