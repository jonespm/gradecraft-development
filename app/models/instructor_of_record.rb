class InstructorOfRecord
  attr_reader :course

  def initialize(course)
    @course = course
  end

  def update_course_memberships(user_ids)
    current_instructors_of_record(user_ids).each do |membership|
      membership.update_attributes instructor_of_record: false
    end

    not_instructors_of_record(user_ids).map do |membership|
      membership.update_attributes instructor_of_record: true
      membership
    end
  end

  def users
    course.course_memberships.instructors_of_record.map(&:user)
  end

  private

  def current_instructors_of_record(user_ids)
    course.course_memberships.instructors_of_record.select do |membership|
      !user_ids.include?(membership.user_id)
    end
  end

  def not_instructors_of_record(user_ids)
    course.course_memberships.select do |membership|
      user_ids.include?(membership.user_id) && !membership.instructor_of_record?
    end
  end
end
