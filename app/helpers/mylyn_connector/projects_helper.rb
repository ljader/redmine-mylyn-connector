
module MylynConnector::ProjectsHelper
  include MylynConnector::Version

  def get_trackers project
    project.trackers.find(:all);
  end

  def get_issue_custom_fields project, tracker
    icf = project.all_issue_custom_fields;
    icf.delete_if {|x| x.trackers.empty? } #only icf with assigned tracker are valid

    icf = icf & tracker.custom_fields
    icf.compact
  end

  def get_issue_categories project
    project.issue_categories
  end

  def get_members project
    project.members
  end

  def member_assignable? member
    return member.roles.detect() {|role| role.assignable} !=true
  end

  def get_versions project
    return project.shared_versions.each { |v| v.name += " ("  + v.project.name + ")" if project!=v.project}
  end

  def new_issue_allowed? project
    return true if User.current.allowed_to?({:controller => :issues, :action => :create}, project)
    false
  end

  def move_issue_allowed? project
    projects = Issue.allowed_target_projects_on_move
    return projects.include? project
  end

end
