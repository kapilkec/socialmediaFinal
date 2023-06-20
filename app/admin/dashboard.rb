# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Posts" do
          ul do
     
            Post.last(5).map do |post|
              li link_to(post.title, admin_post_path(post))

            end
          end
        end

      end

       column do
        panel "Recent stories" do
          ul do
            Story.last(5).map do |story|
              li link_to(story.note, admin_story_path(story))

            end
          end
        end
  end
end

end

end
