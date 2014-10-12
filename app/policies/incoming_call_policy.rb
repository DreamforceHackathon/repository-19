class IncomingCallPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      practice_phone_numbers = PracticePhoneNumber.joins(:user_practice_phone_numbers).where(user_practice_phone_numbers: { user_id: user.id})
      scope.where(practice_phone_number_id: practice_phone_numbers)
    end
  end

end
