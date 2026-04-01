# AGENTS.md

## Purpose
Use this guide to convert any Helm-style `values.yaml` into a Gravity UI form file named `values.form.json`.

This guide is intentionally generic and reusable across directories and products.

## Inputs and Outputs
- Input: `values.yaml`
- Output: `values.form.json`

## Gravity UI Form Shape
Use this recursive schema pattern:

```json
{
  "type": "object",
  "required": true,
  "defaultValue": {"...": "..."},
  "properties": {
    "key": {
      "type": "object|string|number|boolean",
      "required": true,
      "defaultValue": "...",
      "properties": {},
      "viewSpec": {}
    }
  },
  "viewSpec": {
    "type": "base",
    "layout": "",
    "order": ["..."]
  }
}
```

## Conversion Rules
1. Root node:
- Set `type` to `object`.
- Set `defaultValue` to the full parsed YAML object.
- Create `properties` for each top-level key.
- Set `viewSpec.order` to top-level keys in source order.

2. Object values (maps):
- Use `type: "object"`.
- Add `defaultValue` for that subtree.
- Add nested `properties` for child keys.
- Add `viewSpec`:
  - `type: "base"`
  - `layout: ""`
  - `order`: child keys in source order.

3. Leaf values (scalars):
- `string` -> `type: "string"`
- integer -> `type: "number"`, `format: "int64"` (recommended)
- float -> `type: "number"`
- boolean -> `type: "boolean"`
- Keep `required: true` by default for explicitly present keys.

4. Leaf `viewSpec` defaults:
- String/number:
  - `{"type":"base","layout":"row","layoutTitle":"<Human Title>"}`
- Boolean:
  - `{"type":"switch","layout":"row","layoutTitle":"<Human Title>"}`
- Secret-like strings (`password`, `secret`, `token`, `key`, `mek` in key name):
  - `{"type":"password","layout":"row","layoutTitle":"<Human Title>"}`

5. Naming and structure:
- Keep key names exact, including dashes (`web-ui`, `backend-operator`).
- Do not flatten nested objects unless the product already uses flattened keys.
- Preserve key order from YAML.

6. Optional enrichments (only when known from product docs/examples):
- `enum` + `viewSpec.type: "select"`
- `pattern` for validation
- `layoutDescription`
- numeric bounds (`minimum`, `maximum`)
- `generateRandomValueButton: true` for password fields

## Title Formatting
For `layoutTitle`, convert keys to readable labels:
- `dbPassword` -> `Database password`
- `redisPassword` -> `Redis password`
- `serviceUrl` -> `Service URL`
- `hostname` -> `Hostname`

Use concise, human-readable labels. Do not change actual JSON keys.

## Validation Checklist
After generating `values.form.json`:
1. Validate JSON syntax.
2. Confirm all keys from `values.yaml` exist in form `defaultValue`.
3. Confirm each object node has `viewSpec.order` matching child keys.
4. Confirm secret-like fields use password widgets.
5. Confirm no unintended key renaming or flattening.

## Suggested Commands
```bash
# Validate JSON syntax
jq type values.form.json

# Inspect defaults
jq '.defaultValue' values.form.json
```

## Practical Notes
- Start simple and deterministic; add advanced widgets only when requirements are explicit.
- If an existing `values.form.json` is present for the product, follow its style first.
- Prefer consistency over over-customization.
