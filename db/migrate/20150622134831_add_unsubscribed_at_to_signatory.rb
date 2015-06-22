class AddUnsubscribedAtToSignatory < ActiveRecord::Migration
  def change
    add_column          :signatories,           :unsubscribed_at,        :datetime
  end
end
