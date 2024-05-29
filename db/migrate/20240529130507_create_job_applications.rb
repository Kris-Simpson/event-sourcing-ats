class CreateJobApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :job_applications do |t|
      t.references :job, null: false
      t.string :candidate_name, null: false

      t.timestamps
    end
  end
end
