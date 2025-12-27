class PartnersController < ApplicationController
    before_action :authenticate_user!
#has one はpartner s付かない
    def show
        @partner = current_user.partner
    end

    def new 
        @partner = Partner.new
    end
    def update
        @partner = current_user.partner.build(partner_params)
        if @partner.save
            redirect_to partner_path, success: "OK"
        else
            flash.now[:danger] = "out"
            render :new, status: :unprocessable_entity
        end
    end



    private

    def partner_params
        params.require(:partner).partmit(:name, :sex, :relation, :job, :favorites, :avoidances,:hobbies,
        :budget_min,:budget_max)
    end
end


