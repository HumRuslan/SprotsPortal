class Account::Admin::TeamController < Account::Admin::AdminApplicationController
  before_action :find_team, only: %i[edit destroy update]

  def new
    @team = SubCategory.find(params[:sub_category_id]).teams.build
    @category = params[:category_id]
    authorize([:account, :admin, @team])
    response_is
  end

  def create
    @team = Team.new(team_params)
    flash[:alert] = "Error to create team" unless @team.save
    redirect_to account_admin_category_index_url
  end

  def edit
    @category = params[:category_id]
    response_is
  end

  def update
    flash[:alert] = "Error to update team" unless @team.update(team_params)
    redirect_to account_admin_category_index_url
  end

  def destroy
    @team.destroy
    redirect_to account_admin_category_index_url
  end

  def download_csv
    authorize(%i[account admin team])
    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv; charset=UTF-8; header=present"
        response.headers['Content-Disposition'] = 'attachment; filename=example.csv'

        render template: "account/admin/team/_part/download"
      end
    end
  end

  def upload_csv
    authorize(%i[account admin team])
    if request.post? && params[:file].present?
      upload = Account::Admin::UploadFile.new(params).upload
      flash[:alert] = upload[:message_error] if upload[:message_error].present?
      flash[:notice] = "Upload was finished"
    else
      flash[:alert] = "Error to upload file"
    end
    redirect_to account_admin_category_index_url
  end

  private

  def team_params
    params.require(:team).permit(:name, :sub_category_id)
  end

  def find_team
    @team = Team.find(params['id'])
    authorize([:account, :admin, @team])
  end

  def response_is
    respond_to do |format|
      format.js
    end
  end
end
