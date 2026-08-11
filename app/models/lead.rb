# frozen_string_literal: true

# A visitor who signed up for early access from the Beacon landing page.
class Lead < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :name, with: ->(name) { name.strip }

  validates :email, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100 }

  def display_name
    name.presence || email
  end
end
