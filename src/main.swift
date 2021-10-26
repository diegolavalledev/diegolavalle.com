let site = Site(config,
    contentA: [
        homePage, projectsPage, aboutPage, privacyPage, supportPage, categoriesPage
    ],
    contentB: [
        post_20210904_supporting_markdown
    ],
    templates: [
        pageTemplate, homeTemplate, postTemplate, categoriesTemplate, categoryTemplate
    ],
    generators: [
        categoriesGenerator
    ])

site.render()
