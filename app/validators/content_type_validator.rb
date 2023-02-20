class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.attached? && value.content_type.in?(content_types)

    value.purge if record.new_record?
    record.errors.add(attribute, :content_type, options)
  end

  private

  def content_types
    options.fetch(:in)
  end
end
