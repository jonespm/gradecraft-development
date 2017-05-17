describe API::Users::ImportersController, type: [:disable_external_api, :controller] do
  let(:course) { build_stubbed :course }
  let(:provider) { :canvas }
  let(:access_token) { "topsecret" }
  let(:assignment) { create :assignment, course: course }

  before(:each) do
    login_user(user)
    allow(controller).to receive(:current_course).and_return course
  end

  context "as a professor" do
    let(:user) { build :user, courses: [course], role: :professor }
    let(:syllabus) { double(:syllabus, users: users ) }
    let(:users) do
      {
        data: [{ name: "Robert W" }, { name: "Joe Q" }],
        has_next_page: true
      }
    end
    let!(:user_authorization) do
      create :user_authorization, :canvas, user: user, access_token: access_token,
        expires_at: 2.days.from_now
    end

    before(:each) do
      allow(ActiveLMS::Syllabus).to receive(:new).with("canvas", access_token).and_return \
        syllabus
    end

    describe "#index" do
      it "returns the users" do
        get :index, params: { id: course.id, importer_provider_id: provider },
          format: :json
        expect(assigns :provider_name).to eq "canvas"
        expect(assigns :users).to eq users
      end

      it "renders the template" do
        get :index, params: { id: course.id, importer_provider_id: provider },
          format: :json
        expect(response).to render_template "api/users/importers/index"
      end
    end
  end

  context "as a student" do
    let(:user) { build_stubbed :user, courses: [course], role: :student }

    describe "#index" do
      it "is a protected route" do
        get :index, params: { id: course.id, importer_provider_id: provider },
          format: :json
        expect(response).to have_http_status 302
      end
    end
  end
end
