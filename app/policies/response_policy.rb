class ResponsePolicy < ApplicationPolicy

  def destroy?
    record.incoming_call.user == user
  end

end
