# Home Feature

## Purpose

Dynamic home screen for e-commerce app, fully driven by backend section config.
The UI does not hardcode section content and renders sections by `type` + `layout`.

## Architecture

- `presentation`: Riverpod controllers and reusable widgets.
- `domain`: entities, repository contract, use cases.
- `data`: remote data source, DTO models, repository implementation.

Main paths:

- `lib/features/home/presentation/`
- `lib/features/home/domain/`
- `lib/features/home/data/`
- `lib/core/network/`
- `lib/core/error/`

## API Contract (Mock-First)

Expected response:

```json
{
  "sections": [
    {
      "type": "categories",
      "title": "Categories",
      "layout": "horizontal",
      "items": [{ "id": "c1", "title": "Shoes", "image_url": "..." }]
    },
    {
      "type": "just_for_you",
      "title": "Just For You",
      "layout": "grid_2",
      "has_more": true,
      "next_page": 2,
      "items": [{ "id": "p1", "title": "Item", "image_url": "...", "price": 12 }]
    }
  ]
}
```

## Section Rendering

`HomeSectionRenderer` maps section metadata to widgets:

- `categories` -> `CategorySectionWidget`
- all product-like sections -> `ProductSectionWidget`
- `just_for_you` -> `ProductSectionWidget` + lazy pagination state

## Pagination Strategy

- Pagination is enabled only for `just_for_you`.
- `HomePage` observes scroll position and requests next page near list end.
- `JustForYouPaginationController` appends new items and keeps old items on
  pagination errors with retry action.

## Switching to Real Backend

1. Update `ApiEndpoints.baseUrl`.
2. Ensure backend returns the same payload shape.
3. Remove/disable fallback mock payload in
   `home_remote_data_source.dart` once backend is stable.
