require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::UsersControllerTest < MylynConnector::ControllerTest
  fixtures :users

  def setup
    super
    @controller = MylynConnector::UsersController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/users/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'users'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'users'

    users =  {:tag => 'users', :children => {:count => 9}, :attributes => {:api => cr}}
    user = {:tag => 'user', :attributes => {:id => 5}, :parent => users}
#    assert_tag :tag => 'name', :content => 'Dave2 Lopper2', :parent => user
    assert_tag :tag => 'login', :content => 'dlopper2', :parent => user
    assert_tag :tag => 'firstname', :content => 'Dave2', :parent => user
    assert_tag :tag => 'lastname', :content => 'Lopper2', :parent => user
    assert_tag :tag => 'mail', :content => 'dlopper2@somenet.foo', :parent => user

  end

end
