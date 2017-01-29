require "rails_spec_helper"

feature "grading a group assignment" do
  context "as a professor" do
    let!(:course_membership) { create :course_membership, :professor, user: professor }
    let(:professor) { create :user }
    let!(:assignment) { create :assignment, name: "Group Assignment", course: course_membership.course, grade_scope: "Group" }
    let(:student) { build :user, first_name: "Hermione", last_name: "Granger" }
    let!(:course_membership_2) { create :course_membership, :student, user: student, course: course_membership.course }
    let!(:group) { create :group, course: course_membership.course, name: "Group Name", approved: "Approved" }
    let!(:assignment_group) { create :assignment_group, group: group, assignment: assignment }
    let!(:group_membership) { create :group_membership, student: student, group: group }
    let!(:submission) { create :group_submission, assignment: assignment, group: group }

    before(:each) do
      login_as professor
      visit dashboard_path
    end

    scenario "successfully from the group page" do
      within(".sidebar-container") do
        click_link "Groups"
      end

      expect(current_path).to eq groups_path

      within(".pageContent") do
        click_link "Group Assignment"
      end

      expect(current_path).to eq assignment_path(assignment.id)

      within(".pageContent") do
        click_link "Grade"
      end

      expect(current_path).to eq grade_assignment_group_path(assignment, group)

      within(".pageContent") do
        fill_in("grade_raw_points", with: 100)
        click_button "Submit Grades"
      end
      expect(page).to have_notification_message("notice", "Group Name's Group Assignment was successfully updated")
      grade = Grade.where(assignment_id: assignment.id).last
      expect(grade.group_id).to eq group.id
      expect(grade.submission_id).to eq submission.id
    end
  end
end
