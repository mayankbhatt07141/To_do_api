class User < ApplicationRecord
    has_secure_password 
    has_many :list, dependent: :destroy
end
