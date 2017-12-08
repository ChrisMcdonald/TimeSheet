class UserIncome::UsersController < ApplicationController

	def user_income
		@user = User.find(params[:user_id])
		if params[:project_search]
			if params[:project_search] == ""
				@user_table = @user.time_work
				@sub_total = @user.sub_total(@user_table)
			else

				@user_table = @user.time_work.where(project_id: params[:project_search])
				@sub_total = @user.sub_total(@user_table)

			end

		else
			@user_table = @user.pay_for_user
			@sub_total = @user.sub_total(@user_table)
		end


		respond_to do |format|
			format.csv {send_data @user.to_csv(@user_table), disposition: "attachment;", filename: "#{@user.full_name}-#{Date.today}.csv"}
			format.xlsx # {send_data @time_sheets.to_csv(col_sep: "\t")}
			format.pdf do
				render pdf: "Invoice", header: {right: '[page] of [topage]'}
			end
			format.js
			format.html

		end
	end


end
