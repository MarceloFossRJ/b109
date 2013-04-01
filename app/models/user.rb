class User < ActiveRecord::Base
  has_paper_trail
  
  has_many :posts
  has_many :comments
  
  
  attr_accessor :password, :password_confirmation, :updating_password
  
  attr_accessible :created_by, :email, :is_active, :is_admin, :login, :name, :password_hash, :updated_by, :wrong_login_attempts
  
  attr_protected :id, :password_salt

  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 4..40, :if => :should_validate_password?
  validates_length_of :name, :within => 3..150
  validates_presence_of :login, :email, :password_salt, :name 
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_presence_of :password, :if => :should_validate_password?
  
  def should_validate_password?
    updating_password || new_record?
  end
  
  
  def self.authenticate(login, pass)
    u=find(:first, :conditions=>["login = ?", login])
    return nil if u.nil?
    return u if User.encrypt(pass, u.password_salt)==u.password_hash
    nil
  end
  
  def password=(pass)
    @password=pass
    self.password_salt = User.random_string(10) if !self.password_salt?
    self.password_hash = User.encrypt(@password, self.password_salt)
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
  #cannot delete root user
  #block not active user to login
  #create feature to reset user password
  #create user registration form
  
end
