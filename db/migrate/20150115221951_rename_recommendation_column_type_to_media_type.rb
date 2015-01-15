class RenameRecommendationColumnTypeToMediaType < ActiveRecord::Migration
  def change
    rename_column(:recommendations, :type, :media_type)
  end
end
