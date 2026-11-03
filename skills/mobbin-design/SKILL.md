---
name: mobbin-design
description: Apply the Mobbin-inspired design language from getdesign.md when the user explicitly asks for Mobbin styling or the Mobbin DESIGN.md. Not for unrelated UI work.
---

# Mobbin design reference

The source is [getdesign.md's Mobbin design analysis](https://getdesign.md/mobbin/design-md), an independent reference, not an official Mobbin design system. It is a `DESIGN.md` reference rather than an upstream agent skill.

When requested, use the upstream CLI to retrieve the latest reference from the project root:

```bash
npx --yes getdesign@latest add mobbin
```

Read the path reported by the command before designing or changing the UI. The CLI writes `DESIGN.md` at the project root, or `mobbin/DESIGN.md` if a root `DESIGN.md` already exists; do not overwrite an existing design file. If the reference is already present, reuse it. If retrieval fails or network access is prohibited, explain the limitation and use the existing project design guidance instead.

Treat the reference as inspiration, not as permission to copy Mobbin branding, screenshots, or assets. Adapt it to the user's product and accessibility needs. Respect existing project guidance and any offline or allowed-URL constraints; use local assets and available fonts when remote assets are unavailable.
