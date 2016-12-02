class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, :confirm_password, presence: true, length: {maximum: 15, minimum: 4}
  validates :phone, presence: true, uniqueness: true, length: {maximum: 10, minimum: 10}, numericality: true

  def self.authenticate(email,password)
    @user=User.where(email: email, password: Digest::MD5.hexdigest(password)).last
    if not @user.blank?
      @user
    else
      nil
    end
  end

  before_save :encrypt_password
  def encrypt_password
    self.password = Digest::MD5.hexdigest(password)
    self.confirm_password = Digest::MD5.hexdigest(confirm_password)
  end

  after_validation :compare_password
  def compare_password
    if password != confirm_password
        errors.add(:base, "password and confirm_password do not match")
    end
  end

  before_destroy :take_backup
  def take_backup
    File.open("#{Rails.root}/public/#{self.id}.json","w"){|foo| foo.write(self.to_json)}
  end
end
