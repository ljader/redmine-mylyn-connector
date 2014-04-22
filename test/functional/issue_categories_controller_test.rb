require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::IssueCategoriesControllerTest < MylynConnector::ControllerTest

  fixtures :issue_categories

  def setup
    super
    @controller = MylynConnector::IssueCategoriesController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/issue_categories/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueCategories'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'issueCategories'

    cats =  {:tag => 'issuecategories', :children => {:count => 4}, :attributes => {:api => cr}}
    cat = {:tag => 'issuecategory', :attributes => {:id => 3}, :parent => cats}
    assert_tag :tag => 'name', :content => 'Stock management', :parent => cat

  end

  def test_all_empty_is_valid
    IssueCategory.delete_all

    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/issue_categories/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueCategories'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'issueCategories'

    assert_tag :tag => 'issuecategories', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
