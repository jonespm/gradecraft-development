require_relative "../services/cancels_course_membership"

class CourseMembershipsController < ApplicationController

  before_action :ensure_staff?
  before_action :save_referer, only: [:destroy]

  def create
    @course_membership =
      current_course.course_memberships.create(course_membership_params)
    @course_membership.save

    respond_with @course_membership
    expire_action action: :index
  end

  def deactivate
    course_membership = current_course.course_memberships.find(params[:id])
    if course_membership.update_attribute(:active, false)
      redirect_to students_path, notice: "Some student successfully deleted"
    end
  end

  def destroy
    course_membership = current_course.course_memberships.find(params[:id])
    Services::CancelsCourseMembership.for_student course_membership
    redirect_to session[:return_to],
      notice: "#{course_membership.user.name} was successfully removed from course."
  end

  private

  def course_membership_params
    params.require(:course_membership).permit :auditing, :character_profile,
      :course_id, :instructor_of_record, :user_id, :role, :last_login_at,
      :earned_grade_scheme_element_id, :has_seen_course_onboarding, :active
  end
end
