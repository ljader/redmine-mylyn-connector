require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::IssueCategoriesControllerTest < MylynConnector::ControllerTest

  fixtures :issue_categories

  def setup
    super
    @controller = MylynConnector::IssueCategoriesController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueCategories'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'issueCategories'

    cats =  {:tag => 'issuecategories', :children => {:count => 4}, :attributes => {:api => /^2.7.1/}}
    cat = {:tag => 'issuecategory', :attributes => {:id => 3}, :parent => cats}
    assert_tag :tag => 'name', :content => 'Stock management', :parent => cat

  end

  def test_all_empty_is_valid
    IssueCategory.delete_all

    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueCategories'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'issueCategories'

    assert_tag :tag => 'issuecategories', :children => {:count => 0}, :attributes => {:api => /^2.7.1/}
  end
end
