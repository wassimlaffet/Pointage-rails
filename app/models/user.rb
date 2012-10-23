class User
  include Mongoid::Document
  
  field :name,               type: String
  field :email,              type: String
  field :password,           type: String
  
  validates :email, presence: true, format: { with: /\A[a-z0-9]([\w+-]\.?)*@([\w]+\.)+[a-z]{2,3}\z/i }
  
end