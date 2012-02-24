require 'active_model'
require 'json'

class TravisBuild

  # Using the Rails serializer would be nice, but how to set
  #   include_root_in_json = false since I don't control the .from_json
  #   call anymore ; and this model is not < ActiveRecord::Base.
  #
  # include ActiveModel::Serializers::JSON

  # Instance variables initialized from Travis build JSON.
  JSON_ATTRIBUTES = [ :id,
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
                      :branch ]

  def self.from_json(json)
    new(
      JSON.parse(json).select { |k, v| JSON_ATTRIBUTES.member? k.to_sym }
    )
  end

  def initialize(attributes = {})
    attributes.each_pair { |k, v| instance_variable_set("@#{k}", v) }
  end

  #
  # Methods below provide compatibility with Build (app/models/build.rb).
  #

  def status
    ( @status.nil? || @status == 0 ) ? false : true
  end

  def last_commit
    @commit
  end

  def last_commiter
    @committer_email
  end

end
