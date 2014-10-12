class UserPracticePhoneNumberPolicy < ApplicationPolicy

  def create?
    user == record.practice_phone_number.owner
  end

  def destroy?
    create?
  end

end
