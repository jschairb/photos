require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BucketsController do

  before(:each) do 
    @valid_attrs = { }
    login
    @buckets = mock("Buckets")
    @current_user.stub!(:buckets).and_return(@buckets)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      @buckets.should_receive(:build)
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do 
    it "should save a new bucket with valid attributes" do 
      mock_new_bucket
      @bucket.should_receive(:save).and_return(true)
      post 'create', :bucket => @valid_attrs
    end

    it "should redirect to the show page if saved" do 
      mock_new_bucket
      @bucket.should_receive(:save).and_return(true)
      post 'create', :bucket => @valid_attrs
      response.should be_redirect
      response.should redirect_to(bucket_path(assigns(:bucket)))
    end

    it "should render the new template if invalid" do 
      mock_new_bucket(false)
      @bucket.should_receive(:save).and_return(false)
      post 'create', :bucket => @valid_attrs
      response.should render_template("buckets/new")
    end

    def mock_new_bucket(save_result=true)
      @bucket = mock_model(Bucket) 
      @bucket.stub!(:save).and_return(save_result)
      @buckets.should_receive(:build).and_return(@bucket)
    end
  end

  describe "GET 'edit'" do
    before(:each) do 
      @bucket = mock_model(Bucket, :title => "bucket")
      @buckets.should_receive(:find).and_return(@bucket)
    end

    it "should assign a variable to a bucket" do 
      get 'edit', :id => @bucket.id
      assigns(:bucket).should_not be_nil
    end

    it "should be successful" do
      get 'edit', :id => @bucket.id
      response.should be_success
    end
  end

  describe "PUT 'update'" do 
    before(:each) do 
      @bucket = mock_model(Bucket, :title => 'A new title')
      @buckets.should_receive(:find).and_return(@bucket)
    end
    
    it "should redirect if saved" do 
      @bucket.should_receive(:update_attributes).and_return(true)
      put 'update', :id => @bucket.id, :bucket => { :title => "a new title" }
      response.should be_redirect
      response.should redirect_to(bucket_path(assigns(:bucket)))
    end

    it "should render the edit form if invalid" do 
      @bucket.should_receive(:update_attributes).and_return(false)
      put 'update', :id => @bucket.id, :bucket => { :title => "a new title" }
      response.should render_template("buckets/edit")
    end
  end

  describe "GET 'show'" do
    before(:each) do 
      @bucket = mock_model(Bucket, :title => 'A new title')
      @buckets.should_receive(:find).and_return(@bucket)
    end

    it "should be successful" do
      get 'show', :id => @bucket
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do 
    it "should redirect after destroy" do 
      @bucket = mock_model(Bucket, :title => 'A new title')
      @bucket.should_receive(:destroy).and_return(true)
      @buckets.should_receive(:find).and_return(@bucket)
      delete :destroy, :id => @bucket.id
    end
  end
end
