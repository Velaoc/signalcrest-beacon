# frozen_string_literal: true

# Landing-page lead capture. #create is public; #index is the operator's
# lead inbox and repeats the User#admin? authorization so it stays
# fail-closed even if route constraints change.
class LeadsController < ApplicationController
  def create
    lead = Lead.new(lead_params)
    if lead.save
      redirect_to root_path, notice: "You're on the list. We'll be in touch when Beacon opens its doors."
    else
      redirect_to root_path, alert: lead.errors.full_messages.to_sentence
    end
  end

  def index
    head :not_found unless current_user&.admin?
    @leads = Lead.order(created_at: :desc).limit(200)
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :email)
  end
end
