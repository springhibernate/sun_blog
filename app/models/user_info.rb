require "digest/sha2"

class UserInfo < ActiveRecord::Base
  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_presence_of :password_ori
  validates_confirmation_of :password_ori
  validate :exist_password

  #password_ori is not a field of table(user_infos)
  #password is a field of table(user_infos)
  attr_accessor :password_ori
  attr_accessor :password_ori_confirm
  attr_accessor :msg

  #password_ori is used for collect value from form
  #and then encrypt it to password(the field of user_infos)
  def password_ori=(password_ori)
    @password_ori=password_ori
    if password_ori.present?
      if not self.salt
        generate_salt
      end
      self.password=UserInfo.encrypt(password_ori, self.salt)
    end
  end
  #use for encryption
  def generate_salt
    self.salt=self.object_id.to_s+rand.to_s
  end
  #encrypt the password
  def UserInfo.encrypt(password_ori,salt)
    return Digest::SHA2.hexdigest(password_ori+salt)
  end
  #validate whether input a password
  def exist_password
    if not self.password
      errors.add(:password,"you are missing password")
    end
  end

  #check the user whether can login

  USER_NOT_EXIST=I18n.t('wrong_user_name_or_password')
  USER_NO_AVAILABLE=I18n.t('account_is_stop')
  USER_WRONG_PASS=I18n.t('wrong_user_name_or_password')
  def UserInfo.check(user_name,password_ori)
    user=UserInfo.find_by_user_name(user_name)
    if not user
      return UserInfo.new(:msg=>UserInfo::USER_NOT_EXIST)
    end

    if user.status==0
      user.msg=UserInfo::USER_NO_AVAILABLE
      return user
    end

    password=UserInfo.encrypt(password_ori, user.salt)
    if password!=user.password
      user.msg=UserInfo::USER_WRONG_PASS
    end
    return user
  end


end
