class Signatory < ActiveRecord::Base

  # requirements
  validates_presence_of :ip_address
  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :lookup_token

  # formatting
  validates_uniqueness_of :email
  validates_uniqueness_of :lookup_token
  validates_format_of :website, with: /\A((http|https):\/\/)?[a-zA-Z0-9_+\-(.)?]+\.([a-zA-Z]+)((\/)(.*))?\z/i, message: "Invalid URL", allow_nil: true, if: :website?
  validates_format_of :email, with: /\A[A-Z0-9._+%a-z\-]+@[a-zA-Z0-9._+\-%]+\.([a-zA-Z]+)\z/i, message: "Invalid Email", allow_nil: false

  # light check for troublemakers
  validate on: :create do
    self.errors.add(:check_for_max_activity, "is invalid") if !self.check_for_max_activity
  end

  # cleanup
  before_validation :strip_spaces
  before_validation :add_lookup_token
  before_validation :strip_http
  before_save :strip_tags
  after_save :send_verification_email

  # scopes
  scope :pending,   -> { where(verified_at: nil, unsubscribed_at: nil) } # active emails that have not been verified
  scope :verified,  -> { where.not(verified_at: nil) }                   # verified emails (including unsubcribers) - these show on the site as signatories
  scope :active,    -> { where(unsubscribed_at: nil) }                   # emails that have not unsubscribed
  scope :inactive,  -> { where.not(unsubscribed_at: nil) }               # emails that have been unsubscribed

  def check_for_max_activity
    unless Signatory.where(ip_address: self.ip_address).where("created_at > :hour_ago", hour_ago: Time.zone.now - 1.hour).count > 100 ||
      Signatory.where(ip_address: self.ip_address).where("created_at > :twentyfour_ago", twentyfour_ago: Time.zone.now - 24.hours).count > 299
      return true
    else
      return false
    end
  end

  private

    def send_verification_email
      if self.verification_sent_at.blank?
        ## send the email
        SignMailer.send_verification(self.id).deliver_now
      end
    end

    def add_lookup_token
      if self.lookup_token.blank?
        self.lookup_token = Digest::SHA256.hexdigest("#{rand(1..99999)}#{self.id}#{self.email}#{self.updated_at}")
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
        self.website = bare_website.gsub('..','.')
      end
    end

end
