require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::CustomFieldsController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  helper MylynConnector::MylynHelper
  
  def all
    @custom_fields = CustomField.all

    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

end
