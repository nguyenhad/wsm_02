class WorkspaceService
  attr_accessor :workspace, :result_msg, :updated_counter

  def initialize workspace
    @workspace = workspace
    @result_msg = Array.new
    @updated_counter = 0
  end

  def build_sections node_data
    node_data.each do |index, object|
      if object["isGroup"]
        section = @workspace.sections.create section_params(object)
        if section.save
          @updated_counter += 1
        else
          @result_msg.push I18n.t("dashboard.workspaces.update.error_at",
            key: object["key"])
        end
      end
    end
  end

  def build_positions node_data
    node_data.each do |index, object|
      unless object["isGroup"]
        section = Section.find_by_key_and_workspace object["group"],
          @workspace.id
        if section.empty?
          @result_msg.push I18n.t("dashboard.workspaces.update.error_at",
            key: object["key"])
          next
        end
        position = Position.of_user(object["user_id"])
          .of_workspace(@workspace.id)
        if position.empty?
          position = section.first.positions.create position_params(object)
        else
          next
        end
        if position.save
          @updated_counter += 1
        else
          @result_msg.push I18n.t(".error_at", key: object["key"])
        end
      end
    end
  end

  def get_build_results
    [@result_msg, @updated_counter]
  end

  private
  def section_params object
    pos = object["pos"].split " "
    size = object["size"].split " "
    {
      name: object["name"],
      pos_x: pos[0],
      pos_y: pos[1],
      width: size[0],
      height: size[1],
      section_key: object["key"]
    }
  end

  def position_params object
    pos = object["pos"].split " "
    size = object["size"].split " "
    {
      position_type_id: object["type"],
      user_id: object["user_id"],
      pos_x: pos[0],
      pos_y: pos[1],
      width: size[0],
      height: size[1],
      position_key: object["key"],
    }
  end
end
