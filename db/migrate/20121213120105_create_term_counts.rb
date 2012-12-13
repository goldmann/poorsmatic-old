class CreateTermCounts < ActiveRecord::Migration
  def change
    create_table :term_counts do |t|
      t.integer :count

      t.timestamps
    end
  end
end
