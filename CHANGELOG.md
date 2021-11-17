# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Pending
- Safari detects one tracker coming from jsdelivr.net - where Theme Switch is hosted.
- Site header and navigation layout not responding in an ideal way to small phone displays.

### Added
- Fetch discussion responses from GitHub GraphQL API and add them to the post template.

### Fixed
- Author margin on post page.

## [1.0.2] - 2021-10-29
### Added
- View port width and scale value now specified for all pages.

### Fixed
- Site no longer looks too small on mobile.

## [1.0.1] - 2021-10-28
### Added
- Left margin for site title.
- Bottom margin for site header.
- Hard-coded post discussion section.
- Maximum width of 768 pixels for home page, post and other content.

### Changed
- Increased bottom margin site-wide.
- Post tags section style.
- All links except navigation now underline on hover.
- Read Me now shows the right command for running local web server using version of Python shipped with macOS 13.

### Fixed
- Visited links no longer showing with the wrong text color.

## [1.0.0] - 2021-10-26
### Added
- First post.
- Apps and projects index.
- Category page generator and template.
- Intro.
- Category index template.
- Post categories.
- Expandable footer.
- Built with SwiftySites message.
- Theme switcher integration.
- Support for system's color scheme preference.
- Light and dark themes.
- Navigation fragment.
- Home page template.
- Post template.
- Regular page template.

[Unreleased]: https://github.com/diegolavalle/website/compare/1.0.1...HEAD
[1.0.2]: https://github.com/diegolavalle/website/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/diegolavalle/website/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/diegolavalle/website/releases/tag/1.0.0
