require 'redmine'

Rails.logger.info 'Starting redmine-mylyn-connector plugin for Redmine'

Redmine::Plugin.register :redmine_mylyn_connector do
  name 'Mylyn Connector plugin'
  author 'Sven Krzyzak / Daniel Munn'
  description 'This plugin provides a webservice API for Eclipse Mylyn (RESTful)'
  version MylynConnector::Version
end

Redmine::Plugin.find(:redmine_mylyn_connector).requires_redmine(:version_or_higher=>'2.0.0')

require_dependency 'mylyn_connector/hooks/controller_issues_edit_after_save'

#require 'mylyn_connector/patches/custom_value_patch'
Rails.application.config.to_prepare do
  CustomValue.send(:include, MylynConnector::Patches::CustomValuePatch) unless CustomValue.included_modules.include?(MylynConnector::Patches::CustomValuePatch)
end
