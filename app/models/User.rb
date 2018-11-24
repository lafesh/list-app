class User < ActiveRecord::Base
    has_many :lists
    has_secure_password
    validates :first_name, :email, presence: true   
end