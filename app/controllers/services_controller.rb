class ServicesController < ApplicationController
    def test
        res = {:status => "ok!"}
        render :json => res
    end





end
