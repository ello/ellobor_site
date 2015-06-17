class Signatory < ActiveRecord::Base

  # requirements
  validates_presence_of :ip_address
  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :lookup_token

  # formatting
  validates_format_of :website, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: "Invalid URL", allow_nil: false
  # validates_format_of :email, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: "Invalid Email", allow_nil: false # todo

  # light check for troublemakers
  validate do
    self.errors.add(:check_for_max_activity, "is invalid") if !self.check_for_max_activity
  end

  # cleanup
  before_validation :strip_spaces
  before_validation :add_lookup_token
  before_save :strip_http
  before_save :strip_tags

  # scopes
  scope :pending,   -> { where(verified_at: nil) }
  scope :verified,  -> { where.not(verified_at: nil) }

  def check_for_max_activity
    unless Signatory.where(ip_address: self.ip_address).where("created_at > :hour_ago", hour_ago: Time.zone.now - 1.hour).count > 100 ||
      Signatory.where(ip_address: self.ip_address).where("created_at > :twentyfour_ago", twentyfour_ago: Time.zone.now - 24.hours).count > 299
      return true
    else
      return false
    end
  end

  private

    def add_lookup_token
      if self.lookup_token.blank? || self.updated_at_changed?
        self.lookup_token = Digest::SHA256.hexdigest("#{rand(1..9999)}#{self.id}#{self.updated_at}")
      end
    end

    def strip_spaces
      strip_fields = %W( name email website )
      strip_fields.each do |field|
        self.send("#{field}=", self.send(field).strip) unless self.send(field).blank? || !self.send("#{field}_changed?")
      end
    end

    def strip_tags
      self.name =    Nokogiri::HTML(self.name).text unless self.name.blank?
      self.email =   Nokogiri::HTML(self.email).text unless self.email.blank?
      self.website = Nokogiri::HTML(self.website).text unless self.website.blank?
    end

    def strip_http
      unless self.website.blank?
        bare_website = self.website
        bare_website.slice!(/https?:\/\//)
        bare_website = bare_website.gsub(/\/$/,"")
        self.website = bare_website
      end
    end

end
