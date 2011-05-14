require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Starting redmine-mylyn-connector plugin for Redmine'

Redmine::Plugin.register :redmine_mylyn_connector do
  name 'Mylyn Connector plugin'
  author 'Sven Krzyzak'
  description 'This plugin provides a webservice API for Eclipse Mylyn (RESTful)'
  version MylynConnector::Version
end

Redmine::Plugin.find(:redmine_mylyn_connector).requires_redmine(:version_or_higher=>'1.0.0')

require_dependency 'mylyn_connector/hooks/controller_issues_edit_after_save'