class PromptPolicy < ApplicationPolicy

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
