class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :job_events do |t|
      t.belongs_to :job, null: false, foreign_key: true
      t.string :type
      t.json :data

      t.timestamps
    end
  end
end
