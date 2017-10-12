class AddShowGradePredictorToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :show_grade_predictor, :boolean, null: true, default: true
  end
end
