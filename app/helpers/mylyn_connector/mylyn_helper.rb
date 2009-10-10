
module MylynConnector::MylynHelper

  def integer_list id_based
    id_based.collect! { |i| i.id.to_s + " "}
    id_based.to_s.strip
  end

end
