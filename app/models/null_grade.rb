class NullGrade
  attr_accessor :predicted_score

  def initialize
    @predicted_score = 0
  end

  def is_student_visible?
    true
  end

  def id
    0
  end

  def team_id
    0
  end

  def challenge_id
    0
  end

  def point_total
    555
  end

  def score
    nil
  end

  def raw_score
    nil
  end

  def final_score
    nil
  end

  def status
    nil
  end

  def pass_fail_status
    nil
  end

  def feedback
    nil
  end

  def updated_at
    nil
  end
end
