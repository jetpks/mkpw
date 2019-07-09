require 'pathname'

require_relative '../lib/mkpw'

SPEC_DIR = Pathname.new(__dir__)
FIXTURE_DIR = SPEC_DIR.join('fixtures')