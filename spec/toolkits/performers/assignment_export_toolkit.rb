module Toolkits
  module Performers
    module AssignmentExport

      module Context
        def define_context
          # public methods
          let(:course) { @course ||= create(:course) }
          let(:professor_course_membership) { @professor_course_membership ||= create(:professor_course_membership, course: course) }
          let(:professor) { @professor ||= professor_course_membership.user }
          let(:assignment) { @assignment ||= create(:assignment, course: course) }
          let(:team) { @team ||= create(:team) }
          let(:student_course_membership1) { @student_course_membership1 ||= create(:student_course_membership, course: course) }
          let(:student_course_membership2) { @student_course_membership2 ||= create(:student_course_membership, course: course) }
          let(:students) { @students ||= [ student_course_membership1.user, student_course_membership2.user ] }
          let(:student1) { student_course_membership1.user }
          let(:student2) { student_course_membership2.user }
          let(:submission1) { create(:submission, assignment: assignment, student: student_course_membership1.user) }
          let(:submission2) { create(:submission, assignment: assignment, student: student_course_membership2.user) }
          let(:submissions) { [ submission1, submission2 ] }
          let(:assignment_export) do
            create(:assignment_export, course: course, professor: professor, assignment: assignment, team: team)
          end

          let(:job_attrs) {{ professor_id: professor.id, assignment_id: assignment.id, assignment_export_id: assignment_export.id }}
          let(:job_attrs_with_team) { job_attrs.merge(team_id: team.try(:id)) }

          let(:performer) { AssignmentExportPerformer.new(job_attrs) }
          let(:performer_with_team) { AssignmentExportPerformer.new(job_attrs_with_team) }
        end
      end

      module SharedExamples

        RSpec.shared_examples "an assignment export resource" do |resource_name, resource_klass|
          let(:expected_klass) { resource_klass || resource_name.to_s.camelize.constantize }

          it "gets the #{resource_name} from the assignment export" do
            expect(assignment_export).to receive(resource_name).and_return send(resource_name.to_sym)
            subject
          end

          it "assigns the #{resource_name} to @#{resource_name}" do
            subject
            expect(performer.instance_variable_get(:"@#{resource_name}")).to eq(send(resource_name.to_sym))
          end

          it "fetches an object that actually has the correct class" do
            subject
            expect(performer.instance_variable_get(:"@#{resource_name}").class).to eq(expected_klass)
          end
        end

        RSpec.shared_examples "an expandable messages hash" do
          it "expands the base messages" do
            expect(performer).to receive(:expand_messages)
            subject
          end
        end

        RSpec.shared_examples "it has a success message" do |message|
          it "has a success message" do
            expect(subject[:success]).to match(message)
          end
        end

        RSpec.shared_examples "it has a failure message" do |message|
          it "has a failure message" do
            expect(subject[:failure]).to match(message)
          end
        end

        RSpec.shared_examples "a created student directory" do |dir_path|
          it "actually creates the directory on disk" do
            subject
            expect(File.exist?(dir_path)).to be_truthy
          end

          it "makes a directory for the student path" do
            expect(Dir).to receive(:mkdir).with(dir_path)
            subject
          end
        end
      end

    end
  end
end
