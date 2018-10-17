# frozen_string_literal: true

require_relative "enumerator_decorator"

module OneShot
  # Decorates an Enumerator::Lazy with an Array-like lookup interface.
  #
  # Note: looking up is eager operation that consumes all earlier values.
  class ArrayLikeEnumerator < EnumeratorDecorator
    def initialize(enumerator)
      @index_read = -1

      enumerator_tracking_index = enumerator.map do |v|
        @index_read += 1
        v
      end

      super(enumerator_tracking_index)
    end

    def [](index)


      _ = enumerator.next while @index_read < index - 1
      enumerator.next
    rescue StopIteration
      nil
    end

    private

    def raise_if_negative(index)
      if index.negative?
        raise ArgumentError,
              "Negative index not supported: #{index}"
      end
    end

    def raise_if_already_read(index)
      if index <= @index_read
        raise IndexAlreadyReadError,
              "Index already read: #{index} (last read: #{@index_read})"
      end
    end
  end

  # Raised when a previously read index is accessed in an ArrayLikeEnumerator
  class IndexAlreadyReadError < IndexError
  end
end
