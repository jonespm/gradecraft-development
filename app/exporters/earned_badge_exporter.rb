class EarnedBadgeExporter
  #all awarded badges for a single course
  def earned_badges_for_course(earned_badges)
    CSV.generate do |csv|
      csv.add_row baseline_headers
      earned_badges.each do |earned_badge|
        csv << [
          earned_badge.student.first_name,
          earned_badge.student.last_name,
          earned_badge.student.username,
          earned_badge.student.email,
          earned_badge.badge.id,
          earned_badge.badge.name,
          earned_badge.feedback,
          earned_badge.created_at
        ]
      end
    end
  end
  
  private

  def baseline_headers
    ["First Name", "Last Name", "Uniqname", "Email", "Badge ID", "Badge Name", "Feedback", "Awarded Date"].freeze
  end
end