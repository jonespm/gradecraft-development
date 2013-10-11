class AssignmentsController < ApplicationController
  before_filter :ensure_staff?, :except => [:feed, :show, :index]

  def index
    @title = "#{term_for :assignment} Index"
    @by_assignment_type = current_course_data.assignments.alphabetical.chronological.group_by(&:assignment_type)
    if current_user.is_student?
      @scores_for_current_course = current_student.scores_for_course(current_course)
    end
  end

   def settings
    @title = "#{term_for :assignments} Settings"
    @assignments = current_course.assignments
    respond_with @assignments
  end

  def show
    @assignment = current_course.assignments.find(params[:id])
    @title = @assignment.name
    @groups = @assignment.groups
    if current_user.is_student?
      @scores_for_current_course = current_student.scores_for_course(current_course)
      @by_assignment_type = current_course_data.assignments.alphabetical.chronological.group_by(&:assignment_type)
    end
  end

  def new
    @title = "Create a New #{term_for :assignment}"
    @assignment = current_course.assignments.new
    @assignment_types = current_course.assignment_types
  end

  def edit
    @assignment = current_course.assignments.find(params[:id])
    @title = "Edit #{@assignment.name}"
    @assignment_rubrics = current_course.rubric_ids.map do |rubric_id|
      @assignment.assignment_rubrics.where(rubric_id: rubric_id).first_or_initialize
    end
  end

  def create
    @assignment = current_course.assignments.new(params[:assignment])
    if @assignment.save
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully created.'
    else
      respond_with @assignment
    end
  end

  def update
    @assignment = current_course.assignments.find(params[:id])
    @assignment.update_attributes(params[:assignment])
    respond_with @assignment
  end

  def destroy
    @assignment = current_course.assignments.find(params[:id])
    @assignment.destroy
    redirect_to assignments_url
  end

  def feed
    @assignments = current_course.assignments
    respond_with @assignments.with_due_date do |format|
      format.ics do
        render :text => CalendarBuilder.new(:assignments => @assignments.with_due_date ).to_ics, :content_type => 'text/calendar'
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:assignment_rubrics_attributes => [:id, :rubric_id, :_destroy])
  end
end
