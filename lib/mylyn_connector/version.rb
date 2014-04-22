module MylynConnector
  module Version

    MAJOR = 2
    MINOR = 8
    TINY  = 2

    # stable/trunk
    BRANCH = 'stable'

    def self.revision
      return nil
    end

    REVISION = self.revision

    ARRAY = [MAJOR, MINOR, TINY, BRANCH, REVISION].compact
    STRING = ARRAY.join('.')

    REDMINE = Redmine::VERSION.to_a.slice(0,2).join('.')
    
    def self.to_a; ARRAY end
    def self.to_s; STRING end
    def self.redmine_release; REDMINE end

  end
end
