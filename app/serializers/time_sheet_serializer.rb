class TimeSheetSerializer < ActiveModel::Serializer
  attributes :id, :time_in, :time_out
end
