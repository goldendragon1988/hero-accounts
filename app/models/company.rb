class Company < ApplicationRecord
  belongs_to :parent, optional: true, class_name: "Company", foreign_key: :company_id

  validates :name, presence: true
end
