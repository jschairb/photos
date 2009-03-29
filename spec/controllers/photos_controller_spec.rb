require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  before(:each) do 
    @valid_attrs = { }
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
