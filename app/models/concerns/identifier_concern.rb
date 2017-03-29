module IdentifierConcern
  extend ActiveSupport::Concern

  included do
    validates_uniqueness_of :identifier
    before_create :generate_identifier
  end

  # Used for routing helpers
  def to_param
    identifier
  end

  private
    def generate_identifier
      strings = %w(Abandon About Adams After Again Age Aliens All Alone Always Angeles Another Anthem Apple Asthenia
        Away Balls Bananas Bastard Be Ben Better Blow Bored Boring Boxing Boy Break Breath Brohemian Built Cacophony California
        Carousel Charmer Christmas Clear Coaster College Commercial Country Curve Cynical Dammit Dance Dancing Dangerous Date Day
        Days Dead Death Degenerate Depends Diego Disaster Does Dog Dogs Done Dont Door Down Dumpweed Dysentery Easy Eating Emo
        Enthused Even Everytime Exist Fallen Falls Family Feeling Fentoozler Fighting First Floor Freak Future Gary
        Ghost Girl Give Go Going Gone Good Grandpa Gravity Growing Guy Happy Hearts Her Heres Hey Him Hole Holidays Home Hope If
        Im Interlude Is Its Job Josie Just Kaleidoscope Kids Kings Leave Left Lemmings Letter Lifes Line Lips Little Lonely Longest
        Look Los Lost Love Man Mans Marlboro Matters Me Midnight Miles Mind Miss Mms Mothers Mutt My Myself Natives New Next Night
        No Not Now Obvious One Online Only Out Over Overboard Part Party Pathetic Peggy Pet Place Planet Please Point Pool Pretty
        Rabbit Reason Rebecca Reckless Red Reebok Reunion Rhapsody Rock Roller Romeo Sally San Satellites Scene Shampoo She Shes
        Show Shut Skies Small Smell Snake So Sober Sometimes Song Songs Sorry Stay Stockholm Story Strings Such Sue Syndrome Take
        Target Teenage Tell That The Thing Things This Time Times Toast Together Touchdown Tv Two Up View Violence Voyeur Waggy Wah
        Was Wasting Weekend Well Wendy Went What Whats When Wishing Without Wont Wrecked Wrong You Young Your Zulu)

      loop do
        self.identifier = strings.sample(3).join()
        break unless self.class.exists?(:identifier => self.identifier)
      end
    end
end