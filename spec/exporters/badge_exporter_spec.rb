describe BadgeExporter do
  let(:badge) { create :badge }
  let(:course) { create :course }
  let!(:student1) { create(:course_membership, :student, course: course, active: true).user }
  let!(:student2) { create(:course_membership, :student, course: course, active: true).user }
  subject { BadgeExporter.new }

  describe "#export_sample_badge_file" do
    it "generates a CSV with grade statuses if the assignment is pass/fail and we
        want statuses as plaintext", :unreliable do
      csv = CSV.new(subject.export_sample_badge_file(badge, course)).read
      expect(csv.length).to eq 3
      expect(csv[1][0]).to eq student1.first_name
      expect(csv[1][1]).to eq student1.last_name
      expect(csv[1][2]).to eq student1.email
      expect(csv[1][3]).to eq nil
      expect(csv[1][4]).to eq nil
      expect(csv[1][5]).to eq course.earned_badges.where(student_id: student1.id, badge_id: badge.id).count.to_s
    end
  end
end
