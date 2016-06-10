require_relative "export/model"
require_relative "export/builder"
require_relative "export/buildable"

require_relative "export/class_methods"
require_relative "export/csv"
require_relative "export/record_parser"
require_relative "export/schema_record"
require_relative "export/message"

module Analytics
  module Export
    def self.included(base)
      base.extend(ClassMethods)

      base.class_eval do
        attr_accessor :data
      end
    end

    def initialize(loaded_data)
      self.data = loaded_data
    end

    def records
      @records ||= data[self.class.rows]
    end

    def parsed_schema_records(records_set=nil)
      @parsed_schema_records ||= Analytics::Export::RecordParser.new(
        export: self,
        records: records_set || records
      ).parse_records!
    end

    def generate_csv(path, file_name=nil, schema_record_set=nil)
      Analytics::Export::CSV.new(
        export: self,
        path: path,
        filename: file_name,
        schema_record_set: schema_record_set
      ).generate!
    end
  end
end
