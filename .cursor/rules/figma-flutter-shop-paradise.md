# Figma MCP → Flutter mapping (Shop Paradise)

Use this when translating Figma designs (e.g. [Shoppe eCommerce UI](https://www.figma.com/design/rpzgXOHpVC4vS6Yu55DpnL/Shoppe---eCommerce-Clothing-Fashion-Store-Multi-Purpose-UI-Mobile-App-Design--Community-?node-id=0-9526&m=dev)) into this codebase. The app is **Flutter** only; any React/Tailwind output from Figma MCP is **reference**, not copy-paste UI.

## 1. Design tokens

| Concern | Source of truth in code |
|--------|-------------------------|
| Brand / primary | [`lib/core/theme/app_colors.dart`](../../lib/core/theme/app_colors.dart): `AppColors.primary` `0xFF0055FF`, `onPrimary`, `surface`, `onSurface`, `outlineVariant`, etc. |
| Theme assembly | [`lib/core/theme/app_theme.dart`](../../lib/core/theme/app_theme.dart): `AppTheme.light` / `AppTheme.dark`, Material 3 `ColorScheme.fromSeed`, `useMaterial3: true` |
| Typography | **Inter** via `google_fonts` in `AppTheme` (`GoogleFonts.interTextTheme`, `titleLarge` / `headline*` bold for headings) |
| Shape (pills, inputs, buttons) | `AppTheme`: pill radius **28**, filled/elevated buttons min height **52**, search-style inputs use theme `InputDecorationTheme` |
| Spacing | Prefer `8` / `12` / `16` / `24` dp padding patterns already used in feature widgets (e.g. horizontal `16` for lists) |

**Rule:** Map Figma hex and text styles to `Theme.of(context).colorScheme` and `Theme.of(context).textTheme` first; use `AppColors` only when matching brand primitives explicitly.

## 2. Component library

- **No Storybook** in this repo. Reusable UI is **per feature** under `lib/features/<feature>/presentation/widgets/`.
- **Shared core widgets** are minimal; prefer adding small private widget classes next to the screen (`CategoryFilterPage` + widgets under `category_filter/presentation/widgets/`) rather than `buildX()` methods.
- **Material 3** components: `FilledButton`, `OutlinedButton`, `TextButton`, `IconButton`, `ExpansionTile`, `TextField`, `ListView.builder`, `GridView.builder`.

## 3. Frameworks and tooling

- **UI:** Flutter (Dart SDK in `pubspec.yaml`).
- **State:** `flutter_riverpod` (`Provider`, `NotifierProvider`, `AsyncNotifierProvider`).
- **Networking:** `dio` via [`lib/core/network/api_client.dart`](../../lib/core/network/api_client.dart).
- **No** React, Vue, CSS modules, or web bundler for product UI.

## 4. Assets

- **Declared in** [`pubspec.yaml`](../../pubspec.yaml) under `flutter: assets:` (e.g. `assets/images/logo_light.svg`).
- **Remote images:** `Image.network` with **`errorBuilder`** (see `CategorySectionWidget`).
- **SVG:** `flutter_svg` for vector assets where used.

## 5. Icons

- **UI chrome:** Material `Icons.*` (`Icons.search`, `Icons.tune`, `Icons.close`, etc.).
- **Brand:** SVG assets in `assets/images/`.

## 6. Styling approach

- **No CSS.** All styling is Flutter `ThemeData`, widget `decoration`, and `BoxDecoration`.
- **Responsive:** `MediaQuery`, `LayoutBuilder`; wide layouts may use different shell chrome (see shell / web header tests).
- **Lists:** Prefer `ListView.builder` / `GridView.builder` with explicit `physics` when nested (`NeverScrollableScrollPhysics` inside `ExpansionTile` children).

## 7. Project structure (feature-first)

```
lib/
├── core/           # theme, network, errors, locale
├── features/
│   ├── home/
│   ├── category_filter/
│   ├── shell/
│   └── welcome/
└── main.dart
```

Each feature typically has:

- `data/` — datasources, models, `*_repository_impl.dart`
- `domain/` — entities, repository interfaces, use cases
- `presentation/` — pages, widgets, Riverpod providers

**Dependency direction:** presentation → domain ← data. Other features may depend on shared `core` or read another feature’s providers when needed (e.g. home + category filter).

## 8. MCP workflow reminder

1. Pull structure and tokens from Figma (`get_design_context`, screenshots).
2. Map colors/type to `AppTheme` / `AppColors` and existing widgets.
3. Implement new screens as Flutter pages + Riverpod, following the same layer layout as `home` and `category_filter`.
4. Do not paste web component code verbatim; reproduce layout and hierarchy in Flutter.
