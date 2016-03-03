require 'active_record_spec_helper'
require 'scrypt'
require_relative "../../config/initializers/regex" unless defined? REGEX

RSpec.describe SecureToken do
  subject { SecureToken.new }

  describe "#random_secret_key" do
    let(:result) { subject.instance_eval { random_secret_key } }

    it "creates a 190-bit url-safe base64 hex key" do
      expect(result).to match REGEX["190_BIT_SECRET_KEY"]
    end

    it "caches the @random_secret_key" do
      result
      expect(SecureRandom).not_to receive(:urlsafe_base64).with(190)
      result
    end

    it "sets a @random_secret_key ivar" do
      result
      expect(subject.instance_variable_get(:@random_secret_key)).to eq result
    end
  end

  describe "#authenticates_with?" do
    before(:each) do
      subject.instance_variable_set(:@random_secret_key, "some-secret-key")
      subject.save
    end

    context "the secret key matches the encrypted key" do
      it "authenticates (returns true)" do
        result = subject.authenticates_with?("some-secret-key")
        expect(result).to be_truthy
      end
    end

    context "the secret key does not match the encrypted key" do
      it "does not authenticate (returns false)" do
        result = subject.authenticates_with?("not-the-secret-key")
        expect(result).to be_falsey
      end
    end
  end

  describe "#has_target_of_class?" do
    let(:result) { subject.has_target_of_class?(target_class) }
    let!(:target) { create(:submissions_export) }

    context "searching for the correct class" do
      let(:target_class) { "SubmissionsExport" }

      context "SecureToken has a target and the target class matches the required class" do
        it "returns true" do
          subject.target = target
          subject.save
          expect(result).to be_truthy
        end
      end

      context "no target is present" do
        it "returns false" do
          subject.target = nil
          subject.save
          expect(result).to be_falsey
        end
      end
    end

    context "target is present but the target class doesn't match the required class" do
      let(:target_class) { "SomeOtherClass" }

      it "returns false" do
        subject.target = target
        subject.save
        expect(result).to be_falsey
      end
    end
  end

  describe "protected methods" do

    describe "#set_expires_at" do
      let(:result) { subject.instance_eval { set_expires_at } }
      let(:time_now) { Date.parse("Oct 20 1999").to_time }

      before { allow(Time).to receive(:now) { time_now } }

      it "sets the :expires_at attribute to 7 days from now with timezone" do
        result
        expect(subject[:expires_at]).to eq(time_now + 7.days)
      end

      describe "caching :expires_at on create" do
        it "caches the encrypted key on create" do
          subject.save
          expect(subject[:expires_at]).to eq(time_now + 7.days)
        end
      end
    end

    describe "#cache_encrypted_key" do
      let(:result) { subject.instance_eval { cache_encrypted_key } }
      let(:subject_attrs) do
        { random_secret_key: "stuffkey!!", scrypt_options: {} }
      end

      before do
        allow(subject).to receive_messages(subject_attrs)
        allow(SCrypt::Password).to receive(:create) { "some-encrypted-key" }
      end

      it "creates an encrypted key from the secret key and scrypt options" do
        expect(SCrypt::Password).to receive(:create).with("stuffkey!!", {})
        result
      end

      it "sets the encrypted key value to the :encrypted_key attribute on SecureToken" do
        result
        expect(subject[:encrypted_key]).to eq("some-encrypted-key")
      end

      describe "caching :encrypted_key on create" do
        it "caches the encrypted key on create" do
          subject.save
          expect(subject[:encrypted_key]).to eq("some-encrypted-key")
        end
      end
    end

    describe "#cache_uuid" do
      let(:result) { subject.instance_eval { cache_uuid } }

      before do
        allow(SecureRandom).to receive(:uuid) { "find-this-uuid" }
      end

      it "creates random uuid for the SecureToken" do
        expect(result).to eq "find-this-uuid"
      end

      it "sets the random uuid value to the :uuid attribute on SecureToken" do
        result
        expect(subject[:uuid]).to eq "find-this-uuid"
      end

      describe "caching :uuid on create" do
        it "caches the uuid on create" do
          subject.save
          expect(subject[:uuid]).to eq("find-this-uuid")
        end
      end
    end

    describe "#scrypt_options" do
      let(:result) { subject.instance_eval { scrypt_options } }

      it "creates random uuid for the SecureToken" do
        expect(result).to eq({ key_len: 512 })
      end
    end
  end
end
