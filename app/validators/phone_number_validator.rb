class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\+?\d{10,15}$/
      record.errors[attribute] << (options[:message] || "is not a valid E.164 phone number")
    end
  end
end
