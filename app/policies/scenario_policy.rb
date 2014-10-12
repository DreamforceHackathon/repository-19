class ScenarioPolicy < ApplicationPolicy

  def create?
    record.practice_phone_number.owner == user
  end

  def destroy?
    create?
  end

  def update?
    create?
  end

end
