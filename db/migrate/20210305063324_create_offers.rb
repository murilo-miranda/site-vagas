class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vacancy, null: false, foreign_key: true
      t.text :reason
      t.integer :status, default: 0
      t.date :start_date
      t.decimal :salary

      t.timestamps
    end
  end
end
