# Called from the PredictedAssignmentSerializer, this class manages the
# presentation of a student's grade for an Assignment on the Predictor Page.
#
# PERMISSIONS:
#  * Students CAN ONLY see released grades
#  * Faculty CAN NOT view student predictions

class PredictedGradeSerializer
  attr_reader :current_user

  def id
    grade.id
  end

  def pass_fail_status
    grade.pass_fail_status if grade.is_student_visible?
  end

  def predicted_score
    grade.student == current_user ? grade.predicted_score : 0
  end

  def raw_score
    return 0 if grade.assignment.submissions_have_closed?
    grade.raw_score if grade.is_student_visible?
  end

  def score
    return 0 if grade.assignment.submissions_have_closed?
    grade.score if grade.is_student_visible?
  end

  def initialize(grade, current_user)
    @grade = grade
    @current_user = current_user
  end

  def attributes
    {
      id: id,
      predicted_score: predicted_score,
      score: score,
      raw_score: raw_score,
    }
 end

  private

  attr_reader :grade
end
