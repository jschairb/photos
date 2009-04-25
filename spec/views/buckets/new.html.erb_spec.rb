require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/buckets/new" do
  before(:each) do
    @bucket = mock_model(Bucket, :new_record? => true,
                                 :title => nil)
    assigns[:bucket] = @bucket
    render 'buckets/new'
  end

  it "should have a form tag" do 
    response.should have_tag("form[action=#{buckets_path}]")
  end

  it "has a submit button" do 
    response.should have_tag('input[value=Create]')
  end

end
