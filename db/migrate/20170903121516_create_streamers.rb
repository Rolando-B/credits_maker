class CreateStreamers < ActiveRecord::Migration[5.1]
  def change
    create_table :streamers do |t|
      t.string :name
      t.string :twitch
      t.string :youtube

      t.timestamps
    end
  end
end
