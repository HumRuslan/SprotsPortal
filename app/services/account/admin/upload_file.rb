class Account::Admin::UploadFile
  attr_accessor :category_id, :path

  def initialize(params)
    @category_id = params[:category_id]
    @path = params[:file]
    @message_error = ''
    @teams = []
  end

  def upload
    return { success: false, message_error: "Bad request. Upload failed" } if category_id.blank? || path.blank?

    sub_category_hash = SubCategory.where(category_id: category_id).pluck(:name, :id).to_h
    CSV.foreach(path.path, headers: true).with_index do |row, index|
      next unless check row, index

      unless sub_category_hash.key? row["subcategory"]
        sub_category = SubCategory.create(name: row["subcategory"], category_id: category_id)
        sub_category_hash[sub_category.name] = sub_category.id
      end

      @teams << { name: row["team"],
                  sub_category_id: sub_category_hash[row["subcategory"]],
                  description: row["description"] }
    end

    save_db
    { success: true, message_error: @message_error }
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

  def save_db
    @teams.each_slice(50) do |item|
      Team.import item, on_duplicate_key_ignore: true, validate: false
    end
  end
end
