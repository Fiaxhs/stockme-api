class Image < ApplicationRecord
  has_and_belongs_to_many :albums

  default_scope { where(private: false).limit(20).order('created_at desc') }
  scope :admin, -> { limit(100) }

  mount_uploader :image, ImageUploader

  validates_presence_of :image
  validates_uniqueness_of :identifier

  has_secure_token :secret

  before_create :generate_identifier

  # Used for routing helpers
  def to_param
    identifier
  end

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
    options.merge!({only: [:identifier, :title, :description], methods: [:thumb_url, :small_url, :url]}) do |key, oldval, newval|
      (newval.is_a?(Array) ? (oldval + newval) : (oldval << newval)).uniq
    end
    super options
  end

  private
    def generate_identifier
      strings = %w(13 21 Abandon About Adams After Again Age Aliens All Alone Always Angeles Another Anthem Apple Asthenia
        Away Balls Bananas Bastard Be Ben Better Blow Bored Boring Boxing Boy Break Breath Brohemian Built Cacophony California
        Carousel Charmer Christmas Clear Coaster College Commercial Country Curve Cynical Dammit Dance Dancing Dangerous Date Day
        Days Dead Death Degenerate Depends Diego Disaster Does Dog Dogs Done Dont Door Down Dumpweed Dysentery Easy Eating Emo
        Enthused Even Everytime Exist Fallen Falls Family Feeling Fentoozler Fighting First Floor Freak Future Gary
        Ghost Girl Give Go Going Gone Good Grandpa Gravity Growing Guy Happy Hearts Her Heres Hey Him Hole Holidays Home Hope If
        Im Interlude Is Its Job Josie Just Kaleidoscope Kids Kings Leave Left Lemmings Letter Lifes Line Lips Little Lonely Longest
        Look Los Lost Love Man Mans Marlboro Matters Me Midnight Miles Mind Miss MMs Mothers Mutt My Myself Natives New Next Night
        No Not Now Obvious One Online Only Out Over Overboard Part Party Pathetic Peggy Pet Place Planet Please Point Pool Pretty
        Rabbit Reason Rebecca Reckless Red Reebok Reunion Rhapsody Rock Roller Romeo Sally San Satellites Scene Shampoo She Shes
        Show Shut Skies Small Smell Snake So Sober Sometimes Song Songs Sorry Stay Stockholm Story Strings Such Sue Syndrome Take
        Target Teenage Tell That The Thing Things This Time Times Toast Together Touchdown TV Two Up View Violence Voyeur Waggy Wah
        Was Wasting Weekend Well Wendy Went What Whats When Wishing Without Wont Wrecked Wrong You Young Your Zulu)

      loop do
        self.identifier = strings.sample(3).join()
        break unless self.class.exists?(:identifier => self.identifier)
      end
    end

end