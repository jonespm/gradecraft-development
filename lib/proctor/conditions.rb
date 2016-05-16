module Proctor
  module Conditions
    attr_accessor :requirements, :overrides

    def self.included(base)
      reset_conditions
    end

    def for(condition_set)
      reset_conditions
      send "#{condition_set}_conditions"
    end

    def conditions_satisfied?
      requirements_passed? || valid_overrides_present?
    end

    def reset_conditions
      @requirements = []
      @overrides = []
    end

    def add_requirements(*requirement_names)
      requirement_names.each {|name| add_requirement name }
    end

    def add_overrides(*override_names)
      override_names.each {|name| add_override name }
    end

    def add_requirement(requirement_name)
      @requirements << Proctor::Requirement.new(name: requirement_name) do
        send(requirement_name)
      end
    end

    def add_override(override_name)
      @overrides << Proctor::Override.new name: override_name do
        send(override_name)
      end
    end

    def requirements_passed?
      requirements.all? {|requirement| requirement.passed? }
    end

    def valid_overrides_present?
      overrides.any? {|override| override.valid? }
    end

  end
end
