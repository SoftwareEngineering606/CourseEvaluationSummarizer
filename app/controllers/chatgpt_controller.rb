class ChatgptController < ApplicationController
    def index
      if params[:query]
        @response = ChatgptService.new(params[:query]).call
      end
    end
  end