class AddTelecomCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :telecom_companies do |t|
      t.string :name
      t.timestamps
    end

    TelecomCompany.create(name: "Севстар")
    TelecomCompany.create(name: "Билайн")
    TelecomCompany.create(name: "МТС")
    TelecomCompany.create(name: "Волна")

    end
end
