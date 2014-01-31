class User < ActiveRecord::Base
  has_many :recipe
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /(.+)@(.+)\.(.+)/,
    message: "only email address with this format accepted : (xxxx@xxxx.xxx)" }
end