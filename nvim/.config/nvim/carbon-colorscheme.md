# Carbon Colorscheme Reference

A monochromatic colorscheme derived from the [IBM Carbon Design System](https://carbondesignsystem.com/elements/color/overview/) Color Anatomy palette. The scheme uses the full blue and gray ramps as its primary colors, with the four Carbon alert colors used sparingly as accents.

---

## Source Palette

### Blue Ramp

| Token  | Hex       | RGB               |
|--------|-----------|-------------------|
| blue10 | `#edf5ff` | 237, 245, 255     |
| blue20 | `#d0e2ff` | 208, 226, 255     |
| blue30 | `#a6c8ff` | 166, 200, 255     |
| blue40 | `#78a9ff` | 120, 169, 255     |
| blue50 | `#4589ff` | 69, 137, 255      |
| blue60 | `#0f62fe` | 15, 98, 254       |
| blue70 | `#0043ce` | 0, 67, 206        |
| blue80 | `#002d9c` | 0, 45, 156        |
| blue90 | `#001d6c` | 0, 29, 108        |
| blue100| `#001141` | 0, 17, 65         |

### Gray Ramp

| Token   | Hex       | RGB               |
|---------|-----------|-------------------|
| gray10  | `#f4f4f4` | 244, 244, 244     |
| gray20  | `#e0e0e0` | 224, 224, 224     |
| gray30  | `#c6c6c6` | 198, 198, 198     |
| gray40  | `#a8a8a8` | 168, 168, 168     |
| gray50  | `#8d8d8d` | 141, 141, 141     |
| gray60  | `#6f6f6f` | 111, 111, 111     |
| gray70  | `#525252` | 82, 82, 82        |
| gray80  | `#393939` | 57, 57, 57        |
| gray90  | `#262626` | 38, 38, 38        |
| gray100 | `#161616` | 22, 22, 22        |

### Alert Colors

| Token  | Hex       | RGB            | Meaning          |
|--------|-----------|----------------|------------------|
| red    | `#da1e28` | 218, 30, 40    | Error / danger   |
| orange | `#ff832b` | 255, 131, 43   | Warning / caution|
| yellow | `#fddc69` | 253, 220, 105  | Notice / attention|
| green  | `#24a148` | 36, 161, 72    | Success / safe   |

---

## Semantic Color Roles

These are the roles used by this scheme, mapped from the palette above. Reference these when porting to any application.

### Backgrounds

| Role                   | Hex       | Token   | Notes                              |
|------------------------|-----------|---------|------------------------------------|
| App / editor bg        | `#161616` | gray100 | Darkest surface                    |
| Panel / sidebar / float| `#262626` | gray90  | One step lighter                   |
| Hover / selection      | `#393939` | gray80  | Interactive state overlay          |
| Subtle fill / disabled | `#525252` | gray70  | Borders, dividers                  |
| Visual selection       | `#002d9c` | blue80  | Text selection highlight           |
| Search match           | `#fddc69` | yellow  | High-visibility search highlight   |

### Text

| Role                   | Hex       | Token   | Notes                              |
|------------------------|-----------|---------|------------------------------------|
| Primary text           | `#f4f4f4` | gray10  | Body copy, identifiers             |
| Secondary text         | `#c6c6c6` | gray30  | Labels, captions, properties       |
| Muted text             | `#8d8d8d` | gray50  | Placeholder, disabled              |
| Subtle text / comments | `#6f6f6f` | gray60  | Comments, hints                    |

### Syntax / Code

These roles are intended for code editors and syntax highlighting. The scheme is deliberately monochromatic — most syntax is differentiated by blue shade, not hue.

| Role                   | Hex       | Token   | Notes                                        |
|------------------------|-----------|---------|----------------------------------------------|
| Variables (plain)      | `#f4f4f4` | gray10  | No special color; they are the baseline      |
| Properties / fields    | `#c6c6c6` | gray30  | Slightly dimmer than variables               |
| Operators / punctuation| `#8d8d8d` | gray50  | Recede into background                       |
| Comments               | `#6f6f6f` | gray60  | Italic; very muted                           |
| Namespaces / modules   | `#d0e2ff` | blue20  | Pale blue; informational, not structural     |
| Parameters             | `#d0e2ff` | blue20  | Pale blue; distinct from plain variables     |
| Constants              | `#d0e2ff` | blue20  | Pale blue; non-builtin constants             |
| Functions              | `#a6c8ff` | blue30  | Lighter blue; softer than keywords           |
| Macros / preprocessor  | `#a6c8ff` | blue30  | Same family as functions                     |
| Keywords               | `#78a9ff` | blue40  | Primary syntax blue; control flow, keywords  |
| HTML / template tags   | `#78a9ff` | blue40  | Tags treated as keywords                     |
| Types / classes        | `#4589ff` | blue50  | Richer blue; slightly more saturated         |
| Constructors           | `#4589ff` | blue50  | Same weight as types                         |
| **Strings**            | `#24a148` | green   | **Alert color — only non-blue syntax color** |
| **Numbers**            | `#ff832b` | orange  | **Alert color — numeric literals**           |
| **Booleans / null**    | `#fddc69` | yellow  | **Alert color — special literals**           |
| **Attributes / decorators** | `#fddc69` | yellow | **Alert color — used sparingly**        |

### Diagnostics / Status

| Role             | Hex       | Token  |
|------------------|-----------|--------|
| Error            | `#da1e28` | red    |
| Warning          | `#ff832b` | orange |
| Info             | `#4589ff` | blue50 |
| Hint             | `#a6c8ff` | blue30 |
| Success / OK     | `#24a148` | green  |

### Diff / Version Control

| Role             | Hex       | Token  |
|------------------|-----------|--------|
| Added line       | `#24a148` | green  |
| Changed line     | `#fddc69` | yellow |
| Removed line     | `#da1e28` | red    |
| Changed text     | `#ff832b` | orange |

---

## Derived Tinted Backgrounds

For surfaces that need a subtle colored tint (virtual text, diff gutters, toast backgrounds) — not from the Carbon palette directly, but derived to complement it.

| Role             | Hex       | Derived from        |
|------------------|-----------|---------------------|
| Error surface    | `#2d0a0b` | red, darkened        |
| Warning surface  | `#2d1800` | orange, darkened     |
| Notice surface   | `#252008` | yellow, darkened     |
| Success surface  | `#071c0c` | green, darkened      |
| Info surface     | `#00103d` | blue90/100, darkened |

---

## Design Principles

1. **Blues are structure.** The four active blue shades (blue20–blue50) map to four levels of syntactic importance: pale/informational → functional → control → type-level.
2. **Grays are content.** Variables and plain text carry no color; they are the visual baseline. Punctuation and operators are gray so they recede.
3. **Alert colors are rare.** The four alert colors appear only on literals (strings, numbers, booleans) and diagnostic UI. They never appear on structural syntax like keywords or types. This keeps them meaningful — when you see orange, it is always a value or a warning.
4. **Visual selection is blue.** Using blue80 for selection reinforces the monochromatic identity rather than breaking it with an unrelated hue.
5. **Dark background only.** The scheme is designed exclusively for dark surfaces (gray100 `#161616` base). The blue ramp does not have sufficient contrast on light backgrounds.

---

## Quick Reference Card

```
Backgrounds     #161616  #262626  #393939  #525252
                ───────  ───────  ───────  ───────
                base     panel    hover    fill

Blues (syntax)  #d0e2ff  #a6c8ff  #78a9ff  #4589ff
                ───────  ───────  ───────  ───────
                param    func     keyword  type

Grays (text)    #f4f4f4  #c6c6c6  #8d8d8d  #6f6f6f
                ───────  ───────  ───────  ───────
                primary  secondary muted   comment

Alert colors    #da1e28  #ff832b  #fddc69  #24a148
                ───────  ───────  ───────  ───────
                error    number   boolean  string
                         warning  notice   success
```
