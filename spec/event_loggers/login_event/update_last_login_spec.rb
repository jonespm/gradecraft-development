require "porch"
require "./app/event_loggers/login_event/update_last_login"

describe EventLoggers::UpdateLastLogin do
  describe "#call" do
    let(:context) { Porch::Context.new({ course_membership: course_membership,
                                         created_at: created_at })}
    let(:course_membership) { create :course_membership, :student }
    let(:created_at) { Time.now }

    it "sets the last login for the course membership" do
      result = subject.call context

      expect(result.course_membership.last_login_at).to eq created_at
    end

    it "skips the current action if the course membership is not passed in" do
      context.delete :course_membership

      result = nil
      expect { subject.call context }.to raise_error { |error| result = error.context }

      expect(course_membership.last_login_at).to be_nil
    end

    it "skips the current action if the created at is not passed in" do
      context.delete :created_at

      result = nil
      expect { subject.call context }.to raise_error { |error| result = error.context }

      expect(course_membership.last_login_at).to be_nil
    end
  end
end
