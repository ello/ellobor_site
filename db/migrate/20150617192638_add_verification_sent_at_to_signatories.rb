class AddVerificationSentAtToSignatories < ActiveRecord::Migration
  def change
    add_column          :signatories,           :verification_sent_at,        :datetime
  end
end
