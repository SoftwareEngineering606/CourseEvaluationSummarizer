# frozen_string_literal: true

class ChatgptController < ApplicationController
  def index
    return unless params[:query]

    @response = ChatgptService.new(params[:query]).call
  end
end
