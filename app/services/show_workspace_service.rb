class ShowWorkspaceService
  def initialize workspace
    @workspace = workspace
  end

  def show_hash_workspace
    sections = Array.new
    section_workspaces = @workspace.sections
    section_workspaces.each do |section_workspace|
      temp_section = {
        key: section_workspace.section_key.to_s,
        isGroup: true,
        pos: "#{section_workspace.pos_x} #{section_workspace.pos_y}",
        size: "#{section_workspace.width} #{section_workspace.height}",
        name: section_workspace.name.to_s
      }
      sections.push temp_section
      locations = section_workspace.locations
      locations.each do |location|
        temp_location = {
          key: location.location_key.to_s,
          color: location.location_type.color.to_s,
          pos: "#{location.pos_x} #{location.pos_y}",
          size: "#{location.width} #{location.height}",
          group: section_workspace.section_key.to_s,
          img: location.user.avatar.to_s,
          gender: location.user.gender.to_s,
          role: location.user.role.to_s,
          name: location.user.name.to_s,
          user_id: location.user.id.to_s,
          type: location.location_type_id.to_s,
          birthday: location.user.birthday.to_s
        }
        sections.push temp_location
      end
    end
    sections
  end
end
