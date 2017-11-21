# frozen_string_literal: true
module Mahonia
  class IdentifierDispatcher
    ##
    # @!attribute [rw] registrar
    #   @return [IdentifierRegistrar]
    attr_accessor :registrar

    ##
    # @param registrar [IdentifierRegistrar]
    def initialize(registrar:)
      @registrar = registrar
    end

    class << self
      ##
      # @param type           [Symbol]
      # @param registrar_opts [Hash]
      # @option registrar_opts [Mahonia::IdentifierBuilder] :builder
      #
      # @return [IdentifierDispatcher] a dispatcher with an registrar for the
      #   given type
      # @see IdentifierRegistrar.for
      def for(type, **registrar_opts)
        new(registrar: Mahonia::IdentifierRegistrar.for(type, **registrar_opts))
      end
    end

    ##
    # Assigns an identifier to the object.
    #
    # This involves two steps:
    #   - Registering the identifier with the registrar service via `registrar`.
    #   - Storing the new identifier on the object, in the provided `attribute`.
    #
    # @note the attribute for identifier storage must be multi-valued, and will
    #  be overwritten during assignment.
    #
    # @param attribute [Symbol] the attribute in which to store the identifier.
    #   This attribute will be overwritten during assignment.
    # @param object    [AciveFedora::Base] the object to assign an identifier.
    #
    # @return [AciveFedora::Base] object
    def assign_for(object:, attribute: :identifier)
      record = registrar.register!(object: object)
      object.public_send("#{attribute}=".to_sym, [record.identifier])
      object
    end

    ##
    # Assigns an identifier and saves the object.
    #
    # @see #assign_for
    def assign_for!(object:, attribute: :identifier)
      assign_for(object: object, attribute: attribute).save!
      object
    end
  end
end
