class AddFreeStreamToStream < ActiveRecord::Migration[6.1]
  def change
    add_column :streams, :free_stream, :boolean, defalut: false
  end
end
