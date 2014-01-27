class CreateRewords < ActiveRecord::Migration
  def change
    create_table :rewords do |t|
      t.references :customer
      t.integer    :points

      t.timestamps
    end
  end
end
