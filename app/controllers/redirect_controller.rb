class RedirectController < ApplicationController
  def index
    @shortlink = search
    redirect_to @shortlink.url, status: :temporary_redirect
  end

  private

  def search
    shortlink = Shortlink.find_by(name: params[:shortlink])
    return shortlink if shortlink
    Shortlink.find_by(link_hash: params[:shortlink])
  end
end
