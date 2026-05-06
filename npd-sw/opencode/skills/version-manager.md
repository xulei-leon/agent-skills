# version-manager

## Purpose
Semantic version management for NPD-SW documents. Parse, bump, and track version numbers.

## Interface
- **parse**(version): `SemVer | null` — parse "x.y.z" string
- **bump**(current, type): `string` — bump major/minor/patch
- **extract**(content): `string | null` — find version in doc content
- **bumpFile**(filePath, type): result — read, bump, write doc version
- **infer**(description): type — smart bump type from change description

## Bump Rules
- `patch` (z++): typo/format fixes
- `minor` (y++, z=0): new sections/features
- `major` (x++, y=0, z=0): architecture redesign

## Implementation
`opencode/workflows/version-management.md` — version management workflow
