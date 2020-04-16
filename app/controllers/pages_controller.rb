# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    default_zone = Zone.where(default: true).first
    if default_zone
      redirect_to zone_path(default_zone)
    else
      redirect_to pages_no_zone_path
    end
  end

  def no_zone
    render plain: 'No zones defined or no default zone is defined'
  end
end
