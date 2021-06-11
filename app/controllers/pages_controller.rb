class PagesController < ApplicationController
    def home
      @barbers = Barber.all
    end

    def stylists
    end

    def select
      @barbers = Barber.all
      @services = Service.all
      @turn = Turn.new

      puts @turn
    end
  end