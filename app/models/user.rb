class User < ActiveRecord::Base
  devise :database_authenticatable
  include DeviseTokenAuth::Concerns::User
end
