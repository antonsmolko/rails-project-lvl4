class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :full_name
      t.string :owner_login
      t.string :url
      t.string :html_url
      t.string :language
      t.bigint :github_id
      t.timestamp :pushed_at
      t.string :clone_url
      t.string :last_commit_id
      t.boolean :has_webhook

      t.timestamps

      t.references :user, index: true, foreign_key: true
    end
  end
end
