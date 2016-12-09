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
      positions = section_workspace.positions
      positions.each do |position|
        temp_position = {key: "#{position.user.name}",
          color: "#{position.position_type.color}",
          pos: "#{position.pos_x} #{position.pos_y}",
          size: "#{position.width} #{position.height}",
          group: "#{section_workspace.section_key}", img: "#{position.user.avatar}",
          gender: "#{position.user.gender}",
          role: "#{position.user.role}",
          name: "#{position.user.name}",
          user_id: "#{position.user.id}",
          type: "#{position.position_type_id}",
          birthday: "#{position.user.birthday}"}
        sections.push temp_position
      end
    end
    sections
  end
end
