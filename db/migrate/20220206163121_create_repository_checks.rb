class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.string :aasm_state
      t.boolean :passed, default: false
      t.integer :issues_count
      t.json :listing

      t.timestamps

      t.references :repository, index: true, foreign_key: true
    end
  end
end
