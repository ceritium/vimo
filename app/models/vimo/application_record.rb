# frozen_string_literal: true

module Vimo
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
