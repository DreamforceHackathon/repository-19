class PracticePhoneNumberPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.joins(:user_practice_phone_numbers).where(user_practice_phone_numbers: { user_id: user.id })
    end
  end

  def create?
    true
  end

  def update?
    user == record.owner
  end

end
