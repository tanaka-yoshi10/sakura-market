class User < ApplicationRecord
  has_secure_password

  DUMMY_PASSWORD = 'DUMMY_PASSWORD'

  has_one :address, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 4 }, allow_nil: false

  # [review] admin_flagはis_admin等の名前にしたいです
  default_value_for :admin_flag, false

  # REVIEW パスワード以外の項目のみ更新したいがパスワードのバリデーションに引っかかるのでその対応
  #
  # contextが特別な場合はvalidatesをしないようにしてみてはどうでしょうか。
  # (今ひとつな気もしますが)
  # ちなみに、SonicGardemではパスワード認証はdevise gemを使っています。(そもそもhas_secure_passwordは使っていない)
  #
  # validates :password, length: { minimum: 4 }, allow_nil: false, on: %i(create update)
  # または
  # validates :password, length: { minimum: 4 }, allow_nil: false, if: -> { validation_context != :update_profile_only }
  #
  # def update_profile_only(params)
  #   self.attributes = params
  #   save(context: :update_profile_only)
  # end
  def update_profile_only(user_params)
    self.password = DUMMY_PASSWORD
    self.password_confirmation = DUMMY_PASSWORD
    self.attributes=user_params

    if self.valid?
      self.password = ''
      self.password_confirmation = ''
      self.save(validate: false)
    end
  end
end
