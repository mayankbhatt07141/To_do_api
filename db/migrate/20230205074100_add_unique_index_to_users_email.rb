class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    def change
      add_index :users, :email, unique: true
    end
  end
end
