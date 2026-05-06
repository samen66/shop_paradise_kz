# Service Hub Refactor

## Purpose

This refactor reshapes the Service Hub into a modular feature with clear
boundaries and reusable building blocks, so the team can implement the
full services marketplace incrementally without creating a new monolithic
screen.

## What Was Changed

- Split domain models from UI:
  - `service_hub_role.dart`
  - `service_hub_job.dart`
- Added repository abstraction:
  - `service_hub_repository.dart`
  - `mock_service_hub_repository.dart`
- Added Riverpod providers for role and jobs:
  - `service_hub_providers.dart`
- Replaced old tab-based `StatefulWidget` with role-driven hub screen:
  - `service_hub_page.dart`
- Added first routing scaffolds required by the technical brief:
  - `service_role_select_page.dart`
  - `service_create_step1_page.dart`
  - `service_jobs_feed_page.dart`

## SOLID + DRY Decisions

- **Single responsibility:** each file has one purpose (role model, job model,
  repository, providers, screen).
- **Dependency inversion:** UI reads `ServiceHubRepository` interface, while
  concrete implementation is provided via Riverpod DI.
- **Open for extension:** the mock repository can be replaced with API or local
  data source without touching presentation widgets.
- **DRY UI composition:** repeated blocks are extracted into small private
  widgets (`_RoleSwitcher`, `_JobPreviewCard`, `_SectionTitle`).

## AI Bridge

`ServiceHubPage` consumes `aiDesignProvider` and shows a dedicated CTA card
when an AI result is available. This keeps the bridge visible and ready for
the future multi-step create flow (`/services/create/step1?fromAi=true`).

## Next Iteration

- Expand create flow from step 1 to steps 2-4.
- Add typed models for master profiles, responses, and chat.
- Persist selected role (SharedPreferences) to survive app restart.
- Replace static screen placeholders with full feature pages from the brief.
