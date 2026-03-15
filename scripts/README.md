# Scripts

Doc generation scripts for the Widoco service mesh. Requires `docker compose` and a running `widoco-web` service (`docker compose up -d widoco-web`).

## generate-all-fuseki.sh

Discovers every dataset in Fuseki and generates docs for all of them.

```bash
./scripts/generate-all-fuseki.sh
```

## generate-fuseki.sh

Generates docs for specific datasets by name.

```bash
./scripts/generate-fuseki.sh --name bfo --name bfo_cco
```

## Configuration

Both scripts share `generate-common.sh` and respect these environment variables:

| Variable | Default | Description |
|---|---|---|
| `FUSEKI_PROXY` | `http://widoco-web/fuseki` | Fuseki endpoint (via nginx proxy) |
| `WIDOCO_FLAGS` | `-webVowl -rewriteAll` | Flags passed to Widoco |
| `PORT` | `8484` | Port shown in the completion message |
