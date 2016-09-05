require "light-service"
require "active_record_spec_helper"
require "./app/services/imports_lms_grades/retrieves_lms_grades"

describe Services::Actions::RetrievesLMSGrades do
  let(:access_token) { "TOKEN" }
  let(:assignment_ids) { ["ASSIGNMENT_1", "ASSIGNMENT_2"] }
  let(:course_id) { "COURSE_ID" }
  let(:grade_ids) { ["GRADE_1", "GRADE_2"] }
  let(:provider) { "canvas" }

  it "expects the provider to retrieve the grades from" do
    expect { described_class.execute access_token: access_token, course_id: course_id,
             assignment_ids: assignment_ids, grade_ids: grade_ids }.to \
      raise_error LightService::ExpectedKeysNotInContextError
  end

  it "expects the access token to use to retrieve the grades" do
    expect { described_class.execute provider: provider, course_id: course_id,
             assignment_ids: assignment_ids, grade_ids: grade_ids }.to \
      raise_error LightService::ExpectedKeysNotInContextError
  end

  it "expects the provider's course id to retrieve the grades from" do
    expect { described_class.execute provider: provider, access_token: access_token,
             assignment_ids: assignment_ids, grade_ids: grade_ids }.to \
      raise_error LightService::ExpectedKeysNotInContextError
  end

  it "expects the provider's assignment ids to retrieve the grades from" do
    expect { described_class.execute provider: provider, access_token: access_token,
             course_id: course_id, grade_ids: grade_ids }.to \
      raise_error LightService::ExpectedKeysNotInContextError
  end

  it "expects the provider's grade ids to retrieve the grades from" do
    expect { described_class.execute provider: provider, access_token: access_token,
             course_id: course_id, assignment_ids: assignment_ids }.to \
      raise_error LightService::ExpectedKeysNotInContextError
  end

  it "retrieves the grade details from the lms provider" do
    expect(ActiveLMS::Syllabus).to \
      receive(:new).with(provider, access_token).and_call_original
    expect_any_instance_of(ActiveLMS::Syllabus).to \
      receive(:grades).with(course_id, assignment_ids, grade_ids)
        .and_return [{ grade: "A+" }, { grade: "D-" }]

    result = described_class.execute provider: provider, access_token: access_token,
      course_id: course_id, assignment_ids: assignment_ids, grade_ids: grade_ids
  end
end