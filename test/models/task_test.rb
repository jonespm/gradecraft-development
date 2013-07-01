require "test_helper"

class TaskTest < ActiveSupport::TestCase
  include ValidAttribute::Method

  test "validates presence of assignment" do
    @task = Fabricate.build(:task, :assignment => nil)
    assert_wont have_valid(:assignment).when(nil), @task
    assert_must have_valid(:assignment).when(assignment), @task
  end
end
