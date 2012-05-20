require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::QueriesControllerTest < MylynConnector::ControllerTest
  fixtures :queries

  def setup
    super
    @controller = MylynConnector::QueriesController.new
  end

  def test_all_unauthenticated
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/queries/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'queries'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'queries'

    qs =  {:tag => 'queries', :children => {:count => 5}, :attributes => {:api => cr}}
    q = {:tag => 'query', :attributes => {:id => 6}, :parent => qs}
    assert_tag qs
    assert_tag q

    assert_tag :tag => 'name', :content => 'Open issues grouped by tracker', :parent => q

  end

    def test_all_authenticated
    @request.session[:user_id] = 2

      get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/queries/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'queries'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'queries'

    qs =  {:tag => 'queries', :children => {:count => 7}, :attributes => {:api => cr}}
    assert_tag qs

    assert_tag :tag => 'query', :attributes => {:id => 1}, :child=> {:tag => 'projectid', :content => '1'}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 4}, :children => {:count=> 1}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 5}, :children => {:count=> 1}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 6}, :children => {:count=> 1}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 7}, :child=> {:tag => 'projectid', :content => '2'}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 8}, :child=> {:tag => 'projectid', :content => '2'}, :parent => qs
    assert_tag :tag => 'query', :attributes => {:id => 9}, :children => {:count=> 1}, :parent => qs

  end

  def test_all_empty_is_valid
    Query.delete_all
 
    get :all, :format => 'xml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'queries'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'queries'

    assert_tag :tag => 'queries', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
