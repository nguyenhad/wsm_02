class WorkspaceService
  attr_accessor :workspace, :result_msg, :updated_counter

  def initialize workspace
    @workspace = workspace
    @result_msg = []
    @updated_counter = 0
  end

  def build_sections node_data
    flag = false
    temp_section = []
    section_delete = []
    section_workspaces = @workspace.sections
    if node_data
      node_data.each do |_index, object|
        next if object["isGroup"].blank?

        if section_workspaces.empty?
          section = @workspace.sections.create section_params(object)
          check_save section, object
        else
          section_workspaces.each do |section_workspace|
            if section_workspace.section_key == object["key"]
              flag = false
              temp_section.push section_workspace
              section_delete = section_workspaces - temp_section
              if section_workspace.update section_params(object)
                @updated_counter += 1
              else
                @result_msg.push I18n.t("dashboard.workspaces.update.errors", key: object["key"])
              end
              break
            else
              flag = true
            end
          end
          if flag
            section = @workspace.sections.create section_params(object)
            check_save section, object
          end
        end
      end
      section_delete.each(&:destroy)
    else
      section_workspaces.each(&:destroy)
    end
  end

  def build_locations node_data
    flag = false
    temp_location = []
    location_delete = []
    node = []
    location_workspaces = Location.of_workspace @workspace.id
    if node_data
      node_data.each do |_index, object|
        node.push object unless object["isGroup"]
      end
      if node.present?
        node.each do |object|
          if location_workspaces.empty?
            location = Location.create location_params(object)
            check_save location, object
          else
            location_workspaces.each do |location_workspace|
              if location_workspace.location_key == object["key"]
                flag = false
                temp_location.push location_workspace
                location_delete = location_workspaces - temp_location
                if location_workspace.update location_params(object)
                  @updated_counter += 1
                else
                  @result_msg.push I18n.t("dashboard.workspaces.update.errors", key: object["key"])
                end
                break
              else
                flag = true
              end
            end
            if flag
              location = Location.create location_params(object)
              check_save location, object
            end
          end
        end
        location_delete.each(&:destroy)
      else
        location_workspaces.each(&:destroy)
      end
    else
      location_workspaces.each(&:destroy)
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

  def location_params object
    pos = object["pos"].split " "
    size = object["size"].split " "
    {
      location_type_id: object["type"],
      user_id: object["user_id"],
      pos_x: pos[0],
      pos_y: pos[1],
      width: size[0],
      height: size[1],
      section_key: object["group"],
      workspace_id: @workspace.id,
      location_key: object["key"]
    }
  end

  def check_save section, object
    if section.save
      @updated_counter += 1
    else
      @result_msg.push I18n.t("dashboard.workspaces.update.errors",
        key: object["key"])
    end
  end
end
