class AddGradePredictorTermToCoursesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :grade_predictor_term, :string, null: false, default: "Grade Predictor"
  end
end
