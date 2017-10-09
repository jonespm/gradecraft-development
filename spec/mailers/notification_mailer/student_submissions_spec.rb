RSpec.shared_examples "a complete submission email body" do
  it "includes the student's first name" do
    should include student.first_name
  end

  it "includes the assignment name" do
    should include assignment.name
  end

  it "includes the submission created_at timestamp" do
    should include submission.submitted_at
  end
end

# specs for submission notifications that are sent to students
describe NotificationMailer do
  extend Toolkits::Mailers::EmailToolkit::Definitions # brings in helpers for default emails and parts
  define_email_context # taken from the definitions toolkit

  include Toolkits::Mailers::EmailToolkit::SharedExamples # brings in shared examples for emails and parts

  let(:submission) { create(:submission, course: course, student: student, assignment: assignment) }
  let(:student) { create(:user) }
  let(:course) { create(:course, assignment_term: "whifflebox", grade_predictor_term: "crystal ball") }
  let(:assignment) { create(:assignment) }

  describe "#successful_submission" do
    before(:each) do
      NotificationMailer.successful_submission(submission.id).deliver_now
    end

    it "is sent from gradecraft's default mailer email" do
      expect(email.from).to eq [sender]
    end

    it "is sent to the student's email" do
      expect(email.to).to eq [student.email]
    end

    it "has the correct subject" do
      expect(email.subject).to eq "#{course.course_number} - #{assignment.name} Submitted"
    end

    describe "text part body" do
      subject { text_part.body }

      it_behaves_like "a complete submission email body"

      it "doesn't include a template" do
        should_not include "Regents of The University of Michigan"
      end
    end

    describe "html part body" do
      subject { html_part.body }

      it_behaves_like "a complete submission email body"

      it "should use include a template" do
        should include "Regents of The University of Michigan"
      end

      it "declares a doctype" do
        should include "DOCTYPE"
      end
    end
  end

  describe "#updated_submission" do
    before(:each) do
      NotificationMailer.updated_submission(submission.id).deliver_now
    end

    it "is sent from gradecraft's default mailer email" do
      expect(email.from).to eq [sender]
    end

    it "is sent to the student's email" do
      expect(email.to).to eq [student.email]
    end

    it "has the correct subject" do
      expect(email.subject).to eq "#{course.course_number} - #{assignment.name} Submission Updated"
    end

    describe "text part body" do
      subject { text_part.body }

      it_behaves_like "a complete submission email body"

      it "doesn't include a template" do
        should_not include "Regents of The University of Michigan"
      end
    end

    describe "html part body" do
      subject { html_part.body }

      it_behaves_like "a complete submission email body"

      it "should use include a template" do
        should include "Regents of The University of Michigan"
      end

      it "declares a doctype" do
        should include "DOCTYPE"
      end
    end
  end
end
