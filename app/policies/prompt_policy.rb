class PromptPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      practice_phone_numbers = PracticePhoneNumber.joins(:users).where(users: { id: user.id})
      scope.joins(scenario: :practice_phone_number).where(practice_phone_numbers: { id: practice_phone_numbers})
    end
  end

  def create?
    record.scenario.practice_phone_number.owner == user
  end

  def destroy?
    create?
  end

  def update?
    create?
  end

end
