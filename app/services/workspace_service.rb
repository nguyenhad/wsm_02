class WorkspaceService
  attr_accessor :workspace, :result_msg, :updated_counter

  def initialize(workspace)
    @workspace = workspace
    @result_msg = []
    @updated_counter = 0
  end

  def build_sections(node_data)
    flag = false
    temp_section = []
    section_delete = []
    section_workspaces = @workspace.sections
    if node_data
      node_data.each do |_index, object|
        if object["isGroup"]
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
                  @result_msg.push I18n.t("dashboard.workspaces.update.errors",
                    key: object["key"])
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
      end
      section_delete.each(&:destroy)
    else
      section_workspaces.each(&:destroy)
    end
  end

  def build_locations(node_data)
    node_data.each do |_index, object|
      unless object["isGroup"]
        section = Section.find_by_key_and_workspace object["group"],
          @workspace.id
        if section.empty?
          @result_msg.push I18n.t("dashboard.workspaces.update.error_at",
            key: object["key"])
          next
        end
        location = Location.of_user(object["user_id"])
          .of_workspace(@workspace.id)
        if location.empty?
          location = section.first.locations.create location_params(object)
        else
          next
        end
        check_save section, object
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
      location_key: object["key"],
    }
  end

  def check_save section, object
    if section.save
      @updated_counter += 1
    else
      @result_msg.push I18n.t("dashboard.workspaces.update.error_at",
        key: object["key"])
    end
  end
end
