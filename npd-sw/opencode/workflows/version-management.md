# Version Management Workflow

Parse, bump, and track semantic version numbers (x.y.z) across NPD-SW documents.

## Data Types

```typescript
interface SemVer {
  major: number;
  minor: number;
  patch: number;
}

interface VersionBumpResult {
  oldVersion: string;
  newVersion: string;
  bumpType: 'major' | 'minor' | 'patch';
  fileUpdated: boolean;
}
```

## Steps

### Step 1: Parse Version
- Input: version string `"x.y.z"`
- Match pattern: `/^(\d+)\.(\d+)\.(\d+)$/`
- Output: `{ major, minor, patch }` or `null` if invalid
- Validation: reject if not exactly `x.y.z` format

### Step 2: Bump Version
- Input: current version string + bump type
- Rules:
  - `patch` (z++): typo/format fixes
  - `minor` (y++, z=0): new sections/features added
  - `major` (x++, y=0, z=0): architecture redesign
- Output: new version string

### Step 3: Extract from Document
- Scan content for pattern: `Version: x.y.z` or `**Version**: x.y.z`
- Regex: `/(?:Version|版本)[：:]\s*(\d+\.\d+\.\d+)/`
- Output: version string or `null`

### Step 4: Bump Document in Place
- Read file → extract version → compute new → replace in content → write
- Throw error if no version found in file

### Step 5: Infer Bump Type from Description
- Analyze change description text:
  - `架构|重构|breaking|redesign|overhaul` → `major`
  - `新增|增加|添加|new feature|section` → `minor`
  - default → `patch`
- Output: bump type string

## Usage

```markdown
1. Parse: `parseVersion("1.2.3")` → `{ major: 1, minor: 2, patch: 3 }`
2. Bump: `bumpVersion("1.2.3", "minor")` → `"1.3.0"`
3. Extract: `extractVersionFromContent(content)` → `"1.0.0"`
4. Bump file: `bumpDocumentVersion("path/to/doc.md", "patch")`
5. Infer: `inferBumpType("Added user login feature")` → `"minor"`
```
