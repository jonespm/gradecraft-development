describe AssignmentTypesController do
  let(:course) { build(:course)}
  let(:student)  { create(:course_membership, :student, course: course).user }
  let(:professor) { create(:course_membership, :professor, course: course).user }
  let(:assignment_type) { create(:assignment_type, course: course) }
  let(:assignment) { create(:assignment, assignment_type: assignment_type) }

  context "as professor" do
    before(:each) do
      login_user(professor)
    end

    describe "GET index" do
      it "returns assignment types for the current course" do
        get :index
        expect(assigns(:assignment_types)).to eq([assignment_type])
        expect(response).to render_template(:index)
      end
    end

    describe "GET new" do
      it "assigns title and assignment types" do
        get :new
        expect(assigns(:assignment_type)).to be_a_new(AssignmentType)
        expect(response).to render_template(:new)
      end
    end

    describe "GET edit" do
      it "assigns title and assignment types" do
        get :edit, params: { id: assignment_type.id }
        expect(assigns(:assignment_type)).to eq(assignment_type)
        expect(response).to render_template(:edit)
      end
    end

    describe "POST create" do
      it "creates the assignment type with valid attributes"  do
        params = attributes_for(:assignment_type)
        params[:assignment_type_id] = assignment_type
        expect{ post :create, params: { assignment_type: params }}.to \
          change(AssignmentType,:count).by(1)
      end

      it "redirects to new form with invalid attributes" do
        expect{ post :create,
                params: { assignment_type: attributes_for(:assignment_type, name: nil) }}
          .to_not change(AssignmentType,:count)
      end
    end

    describe "POST update" do
      it "updates the assignment type with valid attributes" do
        params = { name: "new name" }
        post :update, params: { id: assignment_type.id, assignment_type: params }
        assignment_type.reload
        expect(response).to redirect_to(assignments_path)
        expect(assignment_type.name).to eq("new name")
      end

      it "redirects to the edit form with invalid attributes" do
        params = { name: nil }
        post :update, params: { id: assignment_type.id, assignment_type: params }
        expect(response).to render_template(:edit)
      end
    end

    describe "GET export_scores" do
      context "with CSV format" do
        it "returns scores in csv form" do
          grade = create(:grade, assignment: assignment, student: student, feedback: "good jorb!")
          get :export_scores, params: { course_id: course.id, id: assignment_type },
            format: :csv
          expect(response.body).to include("First Name,Last Name,Email,Username,Team,Raw Score,Score")
        end
      end
    end

    describe "GET export_all_scores" do
      context "with CSV format" do
        it "returns all scores in csv form" do
          grade = create(:grade, assignment: assignment, student: student, feedback: "good jorb!")
          get :export_all_scores, params: { id: course.id }, format: :csv
          expect(response.body).to include("First Name,Last Name,Email,Username,Team")
        end

        it "redirects to the dashboard if no assignment types exist" do
          assignment_type.destroy
          get :export_all_scores, params: { id: course.id }, format: :csv
          expect(response).to redirect_to dashboard_path
        end
      end
    end

    describe "GET all_grades" do
      it "displays all grades for an assignment type" do
        get :all_grades, params: { id: assignment_type.id }
        expect(assigns(:assignment_type)).to eq(assignment_type)
        expect(response).to render_template(:all_grades)
      end

      describe "with team id in params" do
        it "assigns team and students for team" do
          # we verify only students on team assigned as students
          other_student = create(:user, courses: [course], role: :student)

          team = create(:team, course: course)
          team.students << student

          get :all_grades, params: { id: assignment_type.id, team_id: team.id }
          expect(assigns(:team)).to eq(team)
          expect(assigns(:students)).to eq([student])
        end
      end

      describe "with no team id in params" do
        it "assigns all students if no team supplied" do
          # we verify non-team members also assigned as students
          other_student = create(:user, courses: [course], role: :student)

          team = create(:team, course: course)
          team.students << student

          get :all_grades, params: { id: assignment_type.id }
          expect(assigns(:students)).to include(student)
          expect(assigns(:students)).to include(other_student)
        end
      end
    end

    describe "GET destroy" do
      it "destroys the assignment type" do
        another_assignment_type = create(:assignment_type, course: course)
        expect{ get :destroy, params: { id: another_assignment_type }}.to \
          change(AssignmentType,:count).by(-1)
      end
    end
  end

  context "as student" do
    before(:each) { login_user(student) }

    describe "protected routes" do
      [
        :index,
        :new,
        :create,
        :export_all_scores

      ].each do |route|
          it "#{route} redirects to root" do
            expect(get route).to redirect_to(:root)
          end
        end
    end

    describe "protected routes requiring id in params" do
      [
        :edit,
        :update,
        :destroy,
        :export_scores,
        :all_grades
      ].each do |route|
        it "#{route} redirects to root" do
          expect(get route, params: { id: "1" }).to redirect_to(:root)
        end
      end
    end
  end
end
