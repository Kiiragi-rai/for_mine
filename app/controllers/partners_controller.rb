class PartnersController < ApplicationController
    before_action :authenticate_user!
#has one はpartner s付かない
    def show
        @partner = current_user.partner
    end
#  newとcreate だと入らなかった
    def new 
        @partner = current_user.build_partner
    end
    def create
        @partner = current_user.build_partner(partner_params)
        if @partner.save
            redirect_to partner_path, success: "OK"
        else
            flash.now[:danger] = "out"
            render :new, status: :unprocessable_content
        end
    end

    def edit
        @partner = current_user.partner
    end

    def update
        @partner = current_user.partner
        p @partner
        if @partner.update(partner_params)
            redirect_to partner_path,success: "suceess"
        else
            flash.now[:danger] = "danger"
            render :edit, status: :unprocessable_content
        end

    end

    
        def destroy
            partner = current_user.partner
            partner.destroy!
            redirect_to root_path, success: "success"
        end
    



    private

    # モデルに移動にする？
    def partner_params
        params.require(:partner).permit(:name, :sex, :age,:relation, :job,:favorites, :avoidances,:hobbies,
        :budget_min,:budget_max)


    end 
end



