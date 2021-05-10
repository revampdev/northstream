class CreateStreams < ActiveRecord::Migration[6.1]
  def change
    create_table :streams do |t|
      t.string :name
      t.integer :price
      t.string :slug
      t.string :status
      t.datetime :stream_date
      t.string :stream_key
      t.string :stream_rtmp_link
      t.string :live_stream_id
      t.string :playback_id
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
