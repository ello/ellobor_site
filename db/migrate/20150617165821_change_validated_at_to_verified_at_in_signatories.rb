class ChangeValidatedAtToVerifiedAtInSignatories < ActiveRecord::Migration
  def change
    rename_column       :signatories,         :validated_at, :verified_at
  end
end
