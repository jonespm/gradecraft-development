require "./spec/support/test_classes/lib/analytics/analytics_export_test"

describe Analytics::Export do

  # test modular behaviors in the context of a test class
  describe AnalyticsExportTest do
    subject { described_class.new loaded_data }
    let(:loaded_data) { { some: "data" } }

    it "has been extended with Analytics::Export::ClassMethods" do
      expect(described_class).to respond_to :set_schema
      expect(described_class).to respond_to :rows_by
    end

    it "has an accessible data attribute" do
      subject.data = "some data"
      expect(subject.data).to eq "some data"
    end

    it "sets the loaded data to data on #initialize" do
      expect(subject.data).to eq loaded_data
    end

    describe "#records" do
      let(:loaded_data) { { fossils: ["travis"] } }

      it "selects the data value using the key set in rows_by" do
        expect(subject.records).to eq ["travis"]
      end

      it "caches the records" do
        subject.records
        expect(subject.data).not_to receive(:[]).with :fossils
        subject.records
      end
    end

    describe "#schema_records" do
      let(:schema_records_class) { Analytics::Export::SchemaRecords }
      let(:schema_records_hash) { double(:schema_records).as_null_object }

      before do
        allow(schema_records_class).to receive(:new) { schema_records_hash }
      end

      context "a records_set is given" do
        let(:result) { subject.schema_records ["the-records-set"] }

        it "builds a hash of schema records for records set" do
          expect(schema_records_class).to receive(:new).with \
            export: subject, records: ["the-records-set"]
          result
        end

        it "caches the schema records" do
          result
          expect(schema_records_class).not_to receive(:new)
          result
        end

        it "sets the schema records to @schema_records" do
          result
          expect(subject.instance_variable_get(:@schema_records))
            .to eq schema_records_hash
        end
      end

      context "no records_set is given" do
        let(:result) { subject.schema_records }

        it "builds a hash of schema records using the export records" do
          allow(subject).to receive(:records) { ["some-records"] }
          expect(schema_records_class).to receive(:new).with \
            export: subject, records: ["some-records"]
          result
        end
      end
    end
  end
end
