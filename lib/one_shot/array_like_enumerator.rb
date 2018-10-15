# frozen_string_literal: true

module OneShot
  # Decorates an Enumerator::Lazy with an Array-like lookup interface.
  #
  # Note: looking up is eager operation that consumes all earlier values.
  class ArrayLikeEnumerator < SimpleDelegator
    def initialize(enumerator)
      unless enumerator.is_a? Enumerator::Lazy
        raise ArgumentError, "Enumerator::Lazy required: #{enumerator.inspect}"
      end

      @index_seen = -1

      @enumerator = enumerator.map do |v|
        @index_seen += 1
        v
      end

      super(@enumerator)
    end

    def [](index)
      if index.negative?
        raise ArgumentError, "Negative index not supported: #{index}"
      end

      if index <= @index_seen
        raise ArgumentError, "Index already seen: #{index} (#{@index_seen})"
      end

      _ = @enumerator.next while @index_seen < index - 1
      @enumerator.next
    rescue StopIteration
      nil
    end
  end
end
