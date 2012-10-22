class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :login
  attr_accessor :login
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable #, :validatable

  has_many :terms

  validates :username, presence: true, uniqueness: true, format: {with: /[a-zA-Z0-9_-]/, message: "must only contain numbers, letters, underscores, or dashes"}

  # Copied in from devise validatable, but had to deactivate it to allow validation of username too.
  # https://groups.google.com/forum/?fromgroups=#!topic/plataformatec-devise/QzcCBf7l--g
  validates_presence_of :email
  validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  protected
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
  public




  class << self

    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end

  end
end
