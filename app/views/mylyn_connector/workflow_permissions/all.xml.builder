xml.instruct! :xml, :encoding => "UTF-8"
xml.workflowPermissions root_attribs do
  @workflowPermissions.each do |workflowPermission|
    xml.statusID workflowPermission.old_status.id
    xml.roleID workflowPermission.role.id
    xml.trackerID workflowPermission.tracker.id
    xml.fieldName workflowPermission.field_name
    xml.type workflowPermission.type
    xml.rule workflowPermission.rule
  end
end
