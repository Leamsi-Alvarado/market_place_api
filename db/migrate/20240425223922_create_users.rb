class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end


#null: false; significa que es forzoso que se tenga un valor
#
