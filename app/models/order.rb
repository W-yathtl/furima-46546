class Order < ApplicationRecord
  attr_accessor :token

  belongs_to :purchase_management

end
