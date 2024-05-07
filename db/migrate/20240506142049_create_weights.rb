class CreateWeights < ActiveRecord::Migration[7.1]
  def change
    create_table :weights do |t|
      t.float :value
      t.date :date
      t.belongs_to :user, null: false, foreign_key: true
      t.string :unit, default: 'kg'

      t.timestamps
    end
  end
end
