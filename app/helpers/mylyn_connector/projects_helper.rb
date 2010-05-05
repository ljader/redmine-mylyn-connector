
module MylynConnector::ProjectsHelper
  include MylynConnector::Version::ClassMethods
  
  def edit_issues_allowed? project
    res = User.current.allowed_to?(:edit_issues, project)
    return res !=nil && res !=false
  end

  def get_trackers project
    project.trackers.find(:all);
  end

  def get_issue_custom_fields project
    icf = project.all_issue_custom_fields;
    icf.delete_if {|x| x.trackers.empty? } #only icf with assigned tracker are valid
    icf.compact
  end

  def get_issue_categories project
    project.issue_categories
  end

  def get_members project
    project.members
  end

  def member_assignable? member
    if is09?
      #since 0.9 MemberRole exists
      return member.roles.detect() {|role| role.assignable} !=true
    else
      return member.role.assignable
    end
  end

  def get_versions project
    if is09?
      #since 09 sub(shared)versions exists
      return project.shared_versions.each { |v| v.name += " ("  + v.project.name + ")" if project!=v.project}
    else
      return project.versions
    end

  end

  def get_queries project
    # Code form Issue_helper
    visible = ARCondition.new(["is_public = ? OR user_id = ?", true, User.current.id])
    visible << ["project_id IS NULL OR project_id = ?", project.id]
    Query.find(:all,
      :order => "name ASC",
      :conditions => visible.conditions)
  end

end
