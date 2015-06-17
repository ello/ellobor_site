class AddLookupTokenToSignatory < ActiveRecord::Migration
  def change
    add_column          :signatories,           :lookup_token,        :string, null: false
  end
end
