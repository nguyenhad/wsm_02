class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def open_spreadsheet file
      case File.extname file.original_filename
      when Settings.file_csv
        Roo::CSV.new file.path, file_warning: :ignore
      when Settings.file_xls
        Roo::Excel.new file.path, file_warning: :ignore
      when Settings.file_xlsx
        Roo::Excelx.new file.path, file_warning: :ignore
      end
    end
  end
end
