class CreateSignJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :sign_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vacancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
