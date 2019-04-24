# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# https://stackoverflow.com/questions/44004065/why-does-carrierwave-cause-the-nameerror-uninitialized-constant-micropostpict
# require 'carrierwave/orm/activerecord'