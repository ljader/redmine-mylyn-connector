
module MylynConnector::ProjectsHelper
  def edit_issues_allowed? project
    User.current.allowed_to?(:edit_issues, project) != false
  end

  def get_trackers project
    project.trackers.find(:all);
  end

  def get_issue_custom_fields project
    project.methods.include?('all_issue_custom_fields') ? project.all_issue_custom_fields : project.all_custom_fields;
  end

  def get_issue_categories project
    project.issue_categories
  end

  def get_members project
    project.members
  end

  def member_assignable? member
    #TODO since 0.9 MemberRole exists
    begin
      #since 0.9 MemberRole exists
      return member.roles.detect(false) {|role| role.assignable} != false
    rescue
      return member.role.assignable
    end
  end

  def get_versions project
    project.versions
  end

  def get_queries project
    # Code form Issue_helper
    visible = ARCondition.new(["is_public = ? OR user_id = ?", true, User.current.id])
    visible << ["project_id IS NULL OR project_id = ?", project.id]
    Query.find(:all,
      :order => "name ASC",
      :conditions => visible.conditions)
  end

  def integer_list id_based
    id_based.collect! { |i| i.id.to_s + " "}
    id_based.to_s.strip
  end

end
