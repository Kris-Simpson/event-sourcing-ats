class CreateJobApplicationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :job_application_events do |t|
      t.belongs_to :job_application, null: false, foreign_key: true
      t.string :type
      t.json :data

      t.timestamps
    end
  end
end
