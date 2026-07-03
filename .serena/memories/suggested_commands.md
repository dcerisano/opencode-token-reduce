# Suggested Commands — MCP Framework

## Build
- `./build.sh` — full build (the only build command). Runs Docker container which does: clean → generate → compile → unit tests → integration tests
- llama-server runs as a persistent container (`mcp-llama-server`) — stays alive between builds. Model auto-unloads after 30s idle via `--sleep-idle-seconds 30`.
- To restart llama-server with new flags: `docker rm -f mcp-llama-server` then `./build.sh`
- Never `docker rmi` unless Dockerfile changed — cached images should stay cached.