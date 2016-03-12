require "active_record_spec_helper"
require "resque_spec/scheduler"

require_relative "../toolkits/event_loggers/shared_examples"
require_relative "../toolkits/event_loggers/attributes"
require_relative "../toolkits/event_loggers/event_session"
require_relative "../toolkits/event_loggers/application_event_logger_toolkit"

# PageviewEventLogger.new(attrs).enqueue_in(ResqueManager.time_until_next_lull)
RSpec.describe ApplicationEventLogger, type: :event_logger do
  include InQueueHelper # get help from ResqueSpec
  include Toolkits::EventLoggers::SharedExamples
  include Toolkits::EventLoggers::Attributes
  include Toolkits::EventLoggers::ApplicationEventLoggerToolkit
  extend Toolkits::EventLoggers::EventSession

  # pulls in #event_session attributes from EventLoggers::EventSession
  # creates course, user, student objects, and a request double
  define_event_session_with_request

  let(:new_logger) { ApplicationEventLogger.new }
  let(:expected_base_attrs) { application_logger_base_attrs } # pulled in from Toolkits::EventLoggers::ApplicationEventLoggerToolkit

  # shared examples for EventLogger subclasses
  it_behaves_like "an EventLogger subclass", ApplicationEventLogger, "application"

  describe "#params" do
    it "returns event_sessions[:params]" do
      allow(new_logger).to receive(:event_session) { event_session.merge(params: "param_stuff") }
      expect(new_logger.params).to eq("param_stuff")
    end
  end
end