# Tortugas Consulting, LLC - Website

Modern Hugo-based website with Tailwind CSS, deployed via GitHub Actions.

## Overview

Complete rebuild of tortugas-llc.com, migrated from Assemble.io to Hugo with modern tooling.

**Live Site**: https://tortugas-llc.com

## Tech Stack

- **Hugo** v0.121+ (Extended) - Static site generator
- **Tailwind CSS** v3.4 - Utility-first CSS
- **Vanilla JavaScript** - No jQuery
- **GitHub Actions** - Automated deployment
- **GitHub Pages** - Hosting

## Quick Start

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

Visit http://localhost:1313 to preview the site.

## Project Structure

```
├── config/           # Hugo configuration
├── content/          # Markdown content
│   ├── _index.md
│   ├── about.md
│   └── portfolio/    # 6 portfolio projects
├── layouts/          # HTML templates
├── assets/           # CSS, JS, images
├── data/             # YAML data files
└── static/           # Static assets
```

## Content Management

### Add Portfolio Project

```bash
hugo new portfolio/project-name.md
```

Edit frontmatter:
```yaml
---
title: "Project Name"
technologies: [PHP, React]
services: [Development, Architecture]
website: "https://example.com"
---
```

### Update Timeline

Edit `data/timeline.yaml`:
```yaml
- year: 2024
  title: "Milestone"
  description: "Description"
```

### Update Skills

Edit `data/skills.yaml`:
```yaml
- name: "Technology"
  level: 85
```

## Deployment

Automatic deployment on push to `master`:

```bash
git push origin master
```

GitHub Actions builds and deploys to https://tortugas-llc.com

## Features

- Modern responsive design
- Portfolio filtering (PHP, Node.js, Ruby, React)
- Mobile-first responsive layout
- SEO optimized
- Fast static site generation
- Automated CI/CD

## URLs (Preserved for SEO)

- `/` - Homepage
- `/about/` - About
- `/portfolio/` - Portfolio
- `/kansas-life/`, `/panna/`, etc. - Projects

## Legacy

Old Assemble.io site preserved in `legacy` branch.

## Contact

**Matthew M. Keeler**
- Email: projects@tortugas-llc.com
- GitHub: [@keelerm84](https://github.com/keelerm84)

---

Built with [Hugo](https://gohugo.io/) and [Tailwind CSS](https://tailwindcss.com/)
