# frozen_string_literal: true

require_relative "enumerator_decorator"

module OneShot
  # Decorates an Enumerator::Lazy with an Array-like lookup interface.
  #
  # Note: looking up is eager operation that consumes all earlier values.
  class ArrayLikeEnumerator < EnumeratorDecorator
    ERR_IDX_NEG = "Negative index not supported: %s"
    ERR_IDX_OLD = "Index already read: %s (last read: %s)"

    def initialize(enumerator)
      @last_idx = -1

      enumerator_tracking_index = enumerator.map do |v|
        @last_idx += 1
        v
      end

      super(enumerator_tracking_index)
    end

    def [](idx)
      raise ArgumentError, ERR_IDX_NEG % [idx] if idx.negative?
      raise IndexOldError, ERR_IDX_OLD % [idx, @last_idx] if idx <= @last_idx

      _ = enumerator.next while @last_idx < idx - 1
      enumerator.next
    rescue StopIteration
      nil
    end

    def inspect
      super.sub(/\A#<Enumerator/, "#<ArrayLikeEnumerator")
    end
  end

  # Raised when an index already passed is accessed in an ArrayLikeEnumerator
  class IndexOldError < IndexError
  end
end
