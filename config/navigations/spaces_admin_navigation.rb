SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'ui-state-active'
  navigation.autogenerate_item_ids = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :sidebar, 'Sidebar', home_path do |tabs|
      tabs.dom_class = 'clearfix ui-tabs-nav'
      tabs.item :infos, 'Informações',
        edit_space_path(@space),
        :highlights_on => action_matcher({'spaces' => ['edit', 'update']}),
        :class => 'ui-state-default',
        :link => { :class => "icon-bio_16_18-before" }
      tabs.item :subject, 'Módulos',
        admin_subjects_space_path(@space),
        :highlights_on => action_matcher({'subjects' => ['new', 'create', 'edit', 'update'],
                                          'spaces' => ['admin_subjects']}),
        :class => 'ui-state-default',
        :link => { :class => "icon-subject_16_18-before" },
        :details => { :text => "novo módulo",
                      :class => 'details ',
                      :if => action_matcher({'subjects' => ['new', 'create']})}
      tabs.item :members, 'Membros',
        admin_members_space_path(@space),
        :class => 'ui-state-default',
        :link => { :class => "icon-members_16_18-before" }
    end
  end
end
