
module MylynConnector::MylynHelper

  def root_attribs
    attribs = {:xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version, :authenticated=>authenticated}
    attribs[:authenticatedAs]=authenticated_as if authenticated
    return attribs
  end

  def integer_list id_based
    id_based.collect! {|i| i.id }.join(" ")
  end

  def api_version
    MylynConnector::Version
  end

  def authenticated
    User.anonymous!=User.current
  end

  def authenticated_as
    User.current.login
  end

end
