require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::CustomFieldsController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    @custom_fields = CustomField.all

    respond_to do |format|
      format.xml {render :xml => @custom_fields, :template => 'mylyn_connector/custom_fields/all.rxml'}
    end
  end

end
