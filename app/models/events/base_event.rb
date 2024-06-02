module Events
  class BaseEvent < ApplicationRecord
    self.abstract_class = true

    after_initialize do
      self.data ||= {}
    end
    before_create :apply_and_persist

    def apply(aggregate)
      raise NotImplementedError
    end

    private

    delegate :aggregate_name, to: :class

    class << self
      alias_method :type, :name

      def aggregate_name
        inferred_aggregate = reflect_on_all_associations(:belongs_to).first

        raise "Events must belong to an aggregate" if inferred_aggregate.nil?

        inferred_aggregate.name
      end

      def data_attributes(*attrs)
        @data_attributes ||= []

        attrs.map(&:to_s).each do |attr|
          @data_attributes << attr unless @data_attributes.include?(attr)

          define_method attr do
            self.data ||= {}
            self.data[attr]
          end

          define_method "#{attr}=" do |arg|
            self.data ||= {}
            self.data[attr] = arg
          end
        end

        @data_attributes
      end
    end

    def aggregate=(model)
      public_send("#{aggregate_name}=", model)
    end

    def aggregate
      public_send(aggregate_name)
    end

    def apply_and_persist
      # Lock! (all good, we're in the ActiveRecord callback chain transaction)
      aggregate.lock! if aggregate.persisted?

      # Apply!
      self.aggregate = apply(aggregate)

      # Persist!
      aggregate.save!
    end
  end
end
