class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.order(:codename)
           .pluck(:codename)
           .join("\n")
    end

    # @return [String]
    def all_missions
      Mission.where.not(title: "MyString")
             .order(:title)
             .pluck(:title)
             .join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
        missions = agent.missions
                        .where.not(title: "MyString")
                        .order(:title)
                        .pluck(:title)
                        .join(", ")

        "#{agent.codename}: #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      Agent.all
           .sort_by do |agent|
             [
               -agent.missions.where.not(title: "MyString").count,
               agent.codename
             ]
           end
           .map do |agent|
             missions = agent.missions
                             .where.not(title: "MyString")
                             .order(:title)
                             .pluck(:title)
                             .join(", ")

             count = agent.missions.where.not(title: "MyString").count

             "#{agent.codename} (#{count}): #{missions}"
           end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
        skills = agent.skills
                      .order(:name)
                      .pluck(:name)
                      .join(", ")

        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    # @return [String]
    # @return [String]
    def skills_by_agent_count
      Skill
        .select { |skill| skill.agents.any? }
        .sort_by { |skill| [-skill.agents.count, skill.name] }
        .map do |skill|
          "#{skill.name} (#{skill.agents.count}): #{skill.agents.pluck(:codename).sort.join(', ')}"
        end
         .join("\n")
    end
  end
end
