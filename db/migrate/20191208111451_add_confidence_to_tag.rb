class AddConfidenceToTag < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :confidence, :float
  end
end
