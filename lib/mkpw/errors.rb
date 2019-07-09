module Mkpw
  class MkpwError < StandardError; end

  class FileUnreadableError < MkpwError
    def initialize(path)
      super "Unable to read file at '#{path}'; does it exist?"
    end
  end
end