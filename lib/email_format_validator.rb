require 'rfc822'
module ActiveModel
  module Validations
    class EmailFormatValidator < ActiveModel::EachValidator  
      def validate_each(record, attribute, value)  
        record.errors.add(attribute, :not_a_email, options) if value.to_s !~ ::RFC822::EmailAddress
      end
    end
  end
end