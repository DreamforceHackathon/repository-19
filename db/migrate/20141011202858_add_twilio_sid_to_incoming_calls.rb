class AddTwilioSidToIncomingCalls < ActiveRecord::Migration
  def change
    add_column :incoming_calls, :twilio_sid, :string
  end
end
