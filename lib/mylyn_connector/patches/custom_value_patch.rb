module MylynConnector

  module Patches

    module CustomValuePatch

      def self.included(base) # :nodoc:
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          before_validation :convert_date_values

        end

      end

      module ClassMethods
      end

      module InstanceMethods

        #this will convert ...
        def convert_date_values
          unless self.value.blank?
            self.value = self.value.to_s if self.custom_field.field_format=='date' && self.value.instance_of?(Date)
          end

        end
        
      end
      
    end

  end

end
