class CreateQuizCompletions < ActiveRecord::Migration
  def change
    create_table :quiz_completions do |t|
      t.integer :user_id
      t.integer :quiz_id

      t.timestamps null: false
    end
  end
end
