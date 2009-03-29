require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  #Delete these examples and add some real ones
  it "should use PhotosController" do
    controller.should be_an_instance_of(PhotosController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should instantiate a new Photo" do 
      get 'new'
      assigns(:photo).should_not be_nil
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
