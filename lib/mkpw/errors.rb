# frozen_string_literal: true

module Mkpw
  class MkpwError < StandardError; end

  class FileUnreadableError < MkpwError
    def initialize(path)
      super "Unable to read file at '#{path}'; does it exist?"
    end
  end

  class NotAString < MkpwError
    def initialize(item)
      super "All constituent items must be Strings. Received item '#{item}', which is a #{item.class}"
    end
  end
end
