# frozen_string_literal: true

# Base Application Record; base model for the page
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
