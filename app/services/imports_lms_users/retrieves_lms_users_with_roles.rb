require "active_lms"

module Services
  module Actions
    class RetrievesLMSUsersWithRoles
      extend LightService::Action

      expects :access_token, :provider, :course_id, :user_ids
      promises :users

      executed do |context|
        provider = context.provider
        access_token = context.access_token
        course_id = context.course_id
        user_ids = context.user_ids

        syllabus = ActiveLMS::Syllabus.new provider, access_token
        context.users = syllabus.users(course_id, true, user_ids: user_ids)[:data]
      end
    end
  end
end
