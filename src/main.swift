let site = Site(config,
    contentA: [
        homePage, projectsPage, aboutPage, privacyPage, supportPage, categoriesPage
    ],
    contentB: [
        post_20220202_multiple_backend_environments,
        post_20220106_dockerizing_vapor_development,
        post_20211125_setting_text_field_focus,
        post_20211115_automating_swift_site_generation_netlify,
        post_20211111_urlsession_concurrency_linux,
        post_20210904_supporting_markdown
    ],
    templates: [
        pageTemplate, homeTemplate, postTemplate, categoriesTemplate, categoryTemplate
    ],
    generators: [
        categoriesGenerator
    ])

site.render()
