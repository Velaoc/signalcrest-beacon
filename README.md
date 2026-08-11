<!-- foundation:identity -->
# Signalcrest Beacon

Marketing landing page for the Beacon SaaS product: hero section, features, pricing tiers, FAQ, and an email signup form that stores leads.

- Site: https://signalcrest-beacon.api.holode.xyz
- Support: support@signalcrest-beacon.api.holode.xyz
<!-- /foundation:identity -->

## What this is

Marketing landing page for the Beacon SaaS product: hero section, features, pricing tiers, FAQ, and an email signup form that stores leads.

## Who it is for

- Visitor (anonymous; browses the landing page and can submit an email lead)
- Operator (owns the site; reviews captured leads)

## Main features

- **View landing page** — Anonymous visitor loads the public root and sees hero, features, pricing tiers, and FAQ sections.
- **Sign up with email** — Visitor submits an email and optional name in the signup form; a Lead is stored and a success state is shown.
- **Review leads** — Operator views captured leads in a simple admin index.

## Core entities

- Lead

## Run locally

```bash
bundle install
bin/rails db:prepare
bin/dev
```

Requires Ruby, PostgreSQL, and the usual Rails toolchain. See `bin/setup` if present.

## Demo

Landing page content only: three pricing tiers (Starter, Pro, Enterprise) with prices and feature lists, six features, six FAQ entries. No fake leads seeded.

## Deploy notes

Production `config.hosts` is derived from `domain` in `config/foundation.yml`. Keep that value aligned with the real host or every request will 403.
