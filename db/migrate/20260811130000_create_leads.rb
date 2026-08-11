class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :name, limit: 100
      t.string :email, null: false
      t.string :source, null: false, default: "landing-page"
      t.timestamps
    end
    add_index :leads, :email, unique: true
  end
end
