class List < ActiveRecord::Base
    belongs_to :user
    has_many :list_items
    validates :list_title, presence: true
end