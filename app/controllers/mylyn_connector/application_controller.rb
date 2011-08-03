class MylynConnector::ApplicationController < ApplicationController
  unloadable

  def self.accept_api_auth(*actions)

    begin
      super *actions #Redmine>=1.2
    rescue
      accept_key_auth *actions #Redmine<1.2
    end
  end

end
