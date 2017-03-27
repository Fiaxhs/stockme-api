class Album < ApplicationRecord
  include IdentifierConcern

  has_and_belongs_to_many :images
  has_secure_token :secret
end
