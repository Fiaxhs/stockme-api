class Image < ApplicationRecord
  include IdentifierConcern

  has_and_belongs_to_many :albums

  default_scope { limit(20).order('created_at desc') }
  scope :admin, -> { limit(100) }

  mount_uploader :image, ImageUploader

  validates_presence_of :image

  has_secure_token :secret

  before_save :default_values, :truncate

  def url (option = nil)
    URI.join(ActionController::Base.asset_host, self.image.url(option)).to_s
  end

  def thumb_url
    self.url :thumb
  end

  def small_url
    self.url :small
  end

  def as_json (options = {})
    options.merge!({only: [:identifier, :title, :description, :private], methods: [:thumb_url, :small_url, :url]}) do |key, oldval, newval|
      (newval.is_a?(Array) ? (oldval + newval) : (oldval << newval)).uniq
    end
    super options
  end

  private
    def truncate
      self.title = self.title[0..254] unless self.title.nil?
      self.description = self.description[0..65535] unless self.description.nil?
    end 

    def default_values
      self.private ||= false
    end
end