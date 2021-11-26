class Account::Admin::UploadFile
  attr_accessor :category_id, :path

  def initialize(params)
    @category_id = params[:category_id]
    @path = params[:file].path
    @message_error = ''
  end

  def upload
    teams = []
    CSV.foreach(path, headers: true).with_index do |row, index|
      next unless check row, index

      sub_category_hash = SubCategory.pluck(:name, :id).to_h
      unless sub_category_hash.key? row["subcategory"]
        SubCategory.create(name: row["subcategory"], category_id: category_id)
        sub_category_hash = SubCategory.pluck(:name, :id).to_h
      end
      teams << { name: row["team"],
                 sub_category_id: sub_category_hash[row["subcategory"]],
                 description: row["description"] }
    end

    teams.each_slice(50) do |item|
      Team.import item, on_duplicate_key_ignore: true
    end
    if @message_error.blank?
      { message_error: '' }
    else
      { message_error: @message_error }
    end
  end

  private

  def check(row, index)
    if row["subcategory"].blank? || row["team"].blank?
      @message_error += "row-#{index + 1} subcategory can't be blank, " if row["subcategory"].blank?
      @message_error += "row-#{index + 1} team can't be blank, " if row["team"].blank?
      false
    else
      true
    end
  end
end
