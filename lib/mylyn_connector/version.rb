module MylynConnector
  module Version
    MAJOR = 2
    MINOR = 7
    TINY  = 0

    # stable/trunk
    BRANCH = 'stable'

    def self.revision
      return :RC4
    end

    REVISION = self.revision

    ARRAY = [MAJOR, MINOR, TINY, BRANCH, REVISION].compact
    STRING = ARRAY.join('.')

    REDMINE = Redmine::VERSION.to_a.slice(0,2).join('.')
    
    def self.to_a; ARRAY end
    def self.to_s; STRING end
    def self.redmine_release; REDMINE end

    module ClassMethods

      def is09?
        MylynConnector::Version.redmine_release.to_f >=0.9
      end

      def is10?
        MylynConnector::Version.redmine_release.to_f >=1.0 || is09? && Redmine::VERSION.to_s.include?('devel')
      end

    end

  end
end
