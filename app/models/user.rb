class User < ActiveRecord::Base
  devise :database_authenticatable
  include DeviseTokenAuth::Concerns::User

  has_many :weight_measurements

end
