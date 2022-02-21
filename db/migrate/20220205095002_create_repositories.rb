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
      t.string :git_url

      t.timestamps

      t.references :user, index: true, foreign_key: true
    end
  end
end
