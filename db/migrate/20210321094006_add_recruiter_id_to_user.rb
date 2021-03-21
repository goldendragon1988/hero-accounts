class AddRecruiterIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :recruiter_id, :bigint
  end
end
