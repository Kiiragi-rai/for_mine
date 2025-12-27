class PartnersController < ApplicationController
    before_action :authenticate_user!
#has one はpartner s付かない
    def show
        @partner = current_user.partner
    end

    def new 
        @partner = current_user.build_partner
    end
    def create
        @partner = current_user.build_partner(partner_params)
        if @partner.save
            redirect_to partner_path, success: "OK"
        else
            flash.now[:danger] = "out"
            render :new, status: :unprocessable_entity
        end
    end


    private

    def partner_params
        par = params.require(:partner).permit(:name, :sex, :relation, :job, :favorites, :avoidances,:hobbies,
        :budget_min,:budget_max)

        p par
        
        splitter = /[,\u3001]/  # , と 、どちらもOK

        par[:favorites]  = par[:favorites].to_s.split(splitter).map(&:strip).reject(&:blank?)
        par[:avoidances] = par[:avoidances].to_s.split(splitter).map(&:strip).reject(&:blank?)
        par[:hobbies]    = par[:hobbies].to_s.split(splitter).map(&:strip).reject(&:blank?)

        p par[:favorites] 
        p par[:avoidances] 
        p par[:hobbies] 

        p par
    end
end


