class AddCodilityResultDetailsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :codility_session_id, :string
    add_column :submissions, :task_title, :string
    add_column :submissions, :correctness, :integer
    add_column :submissions, :performance, :integer
    add_column :submissions, :task_score, :integer
  end
end
