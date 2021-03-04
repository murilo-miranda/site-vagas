class ChangeUserValidationOfNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :company_id, true
  end
end
