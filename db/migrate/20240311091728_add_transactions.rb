class AddTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :telecom_company, null: false, foreign_key: true
      t.decimal :amount
      t.integer :status

      t.timestamps

    end
  end
end
