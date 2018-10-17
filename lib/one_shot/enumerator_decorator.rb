# frozen_string_literal: true

module OneShot
  #
  # Base class for Decorators of Enumerator::Lazy
  #
  class EnumeratorDecorator < DelegateClass(Enumerator::Lazy)
    def initialize(enumerator)
      unless enumerator.is_a? Enumerator::Lazy
        raise ArgumentError, "Not an Enumerator::Lazy: #{enumerator.inspect}"
      end

      super(enumerator)
    end

    private

    # @return [Enumerator::Lazy] The underlying decorated enumerator instance
    def enumerator
      @delegate_sd_obj
    end

    #
    # Mark SimpleDelegator#__setobj__ as private
    #
    private :__setobj__ # rubocop:disable Style/AccessModifierDeclarations

    undef_method :rewind
  end
end
