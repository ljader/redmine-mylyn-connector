
module MylynConnector::MylynHelper

  def integer_list id_based
    id_based.collect! {|i| i.id }.join(" ")
  end

  def api_version
    MylynConnector::Version
  end

end
