require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  before(:each) do 
    @valid_attrs = { }
    login
  end

  describe "GET 'index'" do
    before(:each) do 
      @photos = [mock_model(Photo)]
    end

    it "should instantiate a collection of photos" do 
      Photo.should_receive(:find).and_return(@photos)
      get 'index'
    end

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

  describe "POST 'create'" do 
    it "should save a new photo with valid attributes" do 
      mock_new_photo
      @photo.should_receive(:save).and_return(true)
      post 'create', :photo => @valid_attrs
    end

    it "should redirect to the show page if saved" do 
      mock_new_photo
      @photo.should_receive(:save).and_return(true)
      post 'create', :photo => @valid_attrs
      response.should be_redirect
      response.should redirect_to(photo_path(assigns(:photo)))
    end

    it "should render the new template if invalid" do 
      mock_new_photo(false)
      @photo.should_receive(:save).and_return(false)
      post 'create', :photo => @valid_attrs
      response.should render_template("photos/new")
    end

    def mock_new_photo(save_result=true)
      @photo = mock_model(Photo) 
      @photo.stub!(:save).and_return(save_result)
      Photo.should_receive(:new).and_return(@photo)
    end
  end

  describe "GET 'edit'" do
    before(:each) do 
      @photo = mock_model(Photo, :title => "photo")
      Photo.should_receive(:find).and_return(@photo)
    end

    it "should assign a variable to a photo" do 
      get 'edit', :id => @photo.id
      assigns(:photo).should_not be_nil
    end

    it "should be successful" do
      get 'edit', :id => @photo.id
      response.should be_success
    end
  end

  describe "PUT 'update'" do 
    before(:each) do 
      @photo = mock_model(Photo, :title => 'A new title')
      Photo.should_receive(:find).and_return(@photo)
    end
    
    it "should redirect if saved" do 
      @photo.should_receive(:update_attributes).and_return(true)
      put 'update', :id => @photo.id, :photo => { :title => "a new title" }
      response.should be_redirect
      response.should redirect_to(photo_path(assigns(:photo)))
    end

    it "should render the edit form if invalid" do 
      @photo.should_receive(:update_attributes).and_return(false)
      put 'update', :id => @photo.id, :photo => { :title => "a new title" }
      response.should render_template("photos/edit")
    end
  end

  describe "GET 'show'" do
    before(:each) do 
      @photo = mock_model(Photo, :title => 'A new title')
      Photo.should_receive(:find).and_return(@photo)
    end

    it "should be successful" do
      get 'show', :id => @photo
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do 
    it "should redirect after destroy" do 
      @photo = mock_model(Photo, :title => 'A new title')
      Photo.should_receive(:find).and_return(@photo)
      @photo.should_receive(:destroy).and_return(true)
      delete :destroy, :id => @photo.id
    end
  end
end
