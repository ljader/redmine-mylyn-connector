require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Starting redmine-mylyn-connector plugin for Redmine'

Redmine::Plugin.register :redmine_mylyn_connector do
  name 'Mylyn Connector plugin'
  author 'Sven Krzyzak'
  description 'This plugin provides a webservice API for Eclipse Mylyn (RESTful)'
  version MylynConnector::Version
end
