module MylynConnector
  module Version
    MAJOR = 2
    MINOR = 7
    TINY  = 0

    # stable/trunk
    BRANCH = 'stable'

    #Code from Redmine::Version
    def self.revision
      revision = nil

      Dir.glob(File.dirname(__FILE__) + '/../../**/.svn/entries').each {|entries_path|
        if File.readable?(entries_path)
          begin
            f = File.open(entries_path, 'r')
            entries = f.read
            f.close
          if entries.match(%r{^\d+})
            entries.scan(%r{(?:dir|file)\s+(\d+)\s}).each {|m|
              revision = m[0] if !revision || m[0] > revision
            }
          end
          rescue
            # Could not find the current revision
          end
        end
      }
      revision
      #TODO Git implementation
      return RC1
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
