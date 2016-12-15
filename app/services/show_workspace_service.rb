class ShowWorkspaceService

  def initialize workspace
    @workspace = workspace
  end

  def show_hash_workspace
    sections = Array.new
    section_workspaces = @workspace.sections
    section_workspaces.each do |section_workspace|
      temp_section = {key: "#{section_workspace.section_key}", isGroup: true,
        pos: "#{section_workspace.pos_x} #{section_workspace.pos_y}",
        size: "#{section_workspace.width} #{section_workspace.height}",
        name: "#{section_workspace.name}"}
      sections.push temp_section
      locations = section_workspace.locations
      locations.each do |location|
        temp_location = {key: "#{location.location_key}",
          color: "#{location.location_type.color}",
          pos: "#{location.pos_x} #{location.pos_y}",
          size: "#{location.width} #{location.height}",
          group: "#{section_workspace.section_key}", img: "#{location.user.avatar}",
          gender: "#{location.user.gender}",
          role: "#{location.user.role}",
          name: "#{location.user.name}",
          user_id: "#{location.user.id}",
          type: "#{location.location_type_id}",
          birthday: "#{location.user.birthday}"}
        sections.push temp_location
      end
    end
    sections
  end
end
