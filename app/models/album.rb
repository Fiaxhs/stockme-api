class Album < ApplicationRecord
  include IdentifierConcern

  has_and_belongs_to_many :images
  has_secure_token :secret

  def as_json (options = {})
    options.merge!({
      only: [:identifier, :title, :description, :private],
      include: {
        images:{
          only: :identifier,
          methods: :small_url
        }
      }
    }) do |key, oldval, newval|
      (newval.is_a?(Array) ? (oldval + newval) : (oldval << newval)).uniq
    end
    super options
  end
end
