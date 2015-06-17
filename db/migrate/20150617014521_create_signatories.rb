class CreateSignatories < ActiveRecord::Migration
  def change
    create_table :signatories do |t|
      t.string        :name
      t.string        :email
      t.string        :website

      t.datetime      :validated_at
      t.string        :ip_address, null: false

      t.timestamps null: false
    end
  end
end
