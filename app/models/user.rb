class User < ApplicationRecord
  after_create :assign_default_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :must_have_a_role, on: :update

  private
    def assign_default_role
      self.add_role(:admin) if self.roles.blank?
    end

    def must_have_a_role
      unless roles.any?
        errors.add(:roles, 'Mush have at least 1 role')
      end
    end

end
