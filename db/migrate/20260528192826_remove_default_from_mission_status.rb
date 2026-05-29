class RemoveDefaultFromMissionStatus < ActiveRecord::Migration[8.0]
  def change
    change_column_default :missions, :status, nil
  end
end
