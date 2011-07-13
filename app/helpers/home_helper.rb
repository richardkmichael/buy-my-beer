module HomeHelper

  # TODO: Franck insists we can do this nicely in HAML.  Investigate.
  def projects_for(projects)
    project_content = ''.html_safe

    if projects.any?
      projects.each do |project|
        project_content << content_tag('p', project.name)
      end
    else
      project_content = 'You have no projects!'
    end

    project_content
  end

end
