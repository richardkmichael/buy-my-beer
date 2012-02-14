require 'active_model'
require 'json'

class TravisBuild

  # Using the Rails serializer would be nice, but how to set
  #   include_root_in_json = false since I don't control the .from_json
  #   call anymore ; and this model is not < ActiveRecord::Base.
  #
  # include ActiveModel::Serializers::JSON

# {
# "id": 1,
# "number": 1,
# "status": null,
# "started_at": null,
# "finished_at": null,
# "status_message": "Passed",
# "commit": "62aae5f70ceee39123ef",
# "branch": "master",
# "message": "the commit message",
# "compare_url": "https: //github.com/svenfuchs/minimal/compare/master...develop",
# "committed_at": "2011-11-11T11: 11: 11Z",
# "committer_name": "Sven Fuchs",
# "committer_email": "svenfuchs@artweb-design.de",
# "author_name": "Sven Fuchs",
# "author_email": "svenfuchs@artweb-design.de",
# "repository": {
#   "id": 1,
#   "name": "minimal",
#   "owner_name": "svenfuchs",
#   "url": "http: //github.com/svenfuchs/minimal"
#  },

  ATTRIBUTES = [
    :id,
    :number,
    :status,
    :status_message,
    :started_at,
    :finished_at,
    :commit,
    :committed_at,
    :committer_name,
    :committer_email,
    :message,
    :branch
  ]
#   :compare_url,
#   :author_name,
#   :author_email,
#   :repository": {
#   : "id": 1,
#   : "name": "minimal",
#   : "owner_name": "svenfuchs",
#   : "url": "http: //github.com/svenfuchs/minimal"
#   :},

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    attributes.each_pair { |key, value| send("#{key}=", value) }
  end

# def attributes
#   ATTRIBUTES.inject(Hash.new) do |result, key|
#   # ATTRIBUTES.inject(ActiveSupport::HashWithIndifferentAccess.new) do |result, key|
#     result[key] = send(key)
#     result
#   end
# end

  def self.from_json(json)
    j = JSON.parse(json)
    # TODO: This is really a key filter.
    new(
      ATTRIBUTES.inject(Hash.new) do |attributes, attribute_symbol|
        attributes[ attribute_symbol.to_s ] = j[ attribute_symbol.to_s ]
        attributes
      end
    )
  end

# def attributes=(attrs)
#   puts "Attrs.class: #{attrs.class}"
#   puts "Attrs.keys: #{attrs.keys}"
#   puts "Attrs.values: #{attrs.values}"
#   attrs.each_pair { |key, value| send("#{key}=", value) }
# end

# def read_attribute_for_validation(key)
#   send(key)
# end
end
