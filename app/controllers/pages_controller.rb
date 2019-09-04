# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    default_zone = Zone.where(default: true).first
    redirect_to zone_path(default_zone)
  end
end
