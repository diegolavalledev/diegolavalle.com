let site = Site(config,
    contentA: [
    ],
    templates: [
        discussionTemplate
    ],
    generators: [
        discussionsGenerator
    ])

site.render(skipSitemap: true)
