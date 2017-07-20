class API::AssignmentsController < ApplicationController
  include SortsPosition

  before_action :ensure_staff?, only: [:show, :update, :sort]

  # GET api/assignments
  def index
    @assignments = current_course.assignments.ordered

    if current_user_is_student?
      @student = current_student
      @allow_updates = !impersonating? && current_course.active?
      @grades = Grade.for_course(current_course).for_student(current_student)

      if !impersonating?
        @assignments.includes(:predicted_earned_grades)
        @predicted_earned_grades =
          PredictedEarnedGrade.for_course(current_course).for_student(current_student)
      end
    end
  end

  # GET api/assignments/:id
  def show
    @assignment = Assignment.find(params[:id])
  end

  def create
    @assignment = current_course.assignments.new(assignment_params)
    if @assignment.save
      render "api/assignments/show", success: true, status: 201
    else
      render json: {
        message: "failed to save assignment",
        errors: @assignment.errors.messages,
        success: false
        }, status: 400
    end
  end

  # POST api/assignments/:id
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes assignment_params
      render "api/assignments/show", success: true, status: 200
    else
      render json: {
        message: "failed to save assignment",
        errors: @assignment.errors.messages,
        success: false
        }, status: 400
    end
  end

  def sort
    sort_position_for :assignment
  end

  # optional student for graph point:
  # /api/assignments/:assignment_id/analytics
  # /api/assignments/:assignment_id/analytics?student_id=:student_id
  def analytics
    @assignment = Assignment.find(params[:assignment_id])
    @user_score = @assignment.score_for params[:student_id], current_user if params[:student_id].present?
  end

  private

  def assignment_params
    params.require(:assignment).permit(
      :accepts_attachments,
      :accepts_links,
      :accepts_submissions,
      :accepts_submissions_until,
      :accepts_text,
      :assignment_type_id,
      :description,
      :due_at,
      :full_points,
      :grade_scope,
      :hide_analytics,
      :media,
      :name,
      :open_at,
      :pass_fail,
      :purpose,
      :release_necessary,
      :remove_media,
      :required,
      :resubmissions_allowed,
      :show_description_when_locked,
      :show_name_when_locked,
      :show_points_when_locked,
      :show_purpose_when_locked,
      :student_logged,
      :threshold_points,
      :visible,

      # We pass score levels through assignment update for now,
      # planning on replacing them with a single criterion rubric
      assignment_score_levels_attributes: [:id, :name, :points, :_destroy]
    )
  end
end
