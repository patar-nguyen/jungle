class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :name, presence: true

  #use self because it is a class method being called by User class
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    puts user

    if user && user.authenticate(password) 
      return user
    else 
      return nil
    end
  end

end
