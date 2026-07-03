# Technology Stack

## Languages
- **Python 3** — code generation only (tools/); langgraph, langchain-core, grpcio/grpcio-tools
- **Java 21** (Amazon Corretto) — all server implementations, agent nodes, tests
- **Bash** — build orchestration (build.sh)
- **TypeScript** — only for .opencode/ node_modules (buf CLI dependency)

## gRPC & Protobuf
- gRPC Java 1.82.1 (api, core, stub, protobuf, protobuf-lite, inprocess, netty-shaded)
- Protobuf Java 4.35.1
- Buf CLI 1.71.0 — proto registry at buf.build/perlin/private; pushed via `buf push`
- Codegen: `buf.gen.yaml` uses remote plugins (protocolbuffers/java:v35.1, grpc/java:v1.82.1)
- Python stubs generated separately via `grpc_tools.protoc`

## LLM Inference
- llama.cpp (Vulkan binary b9837, pre-built from GitHub releases)
- llama-server on port 11435, OpenAI-compatible HTTP API
- **Model selection**: `select_model()` in build.sh sums free VRAM across ALL GPUs (`nvidia-smi --query-gpu=memory.free` summed). Threshold: >= 10000 MiB → 14B Q4_K_M, else → 3B Q4_K_M.
- **Multi-GPU**: autodetected via `nvidia-smi --query-gpu=count`; uses `--split-mode layer --tensor-split <vram_ratios>`
- **VRAM management**: `-ngl auto` (not hardcoded 99, auto-senses available VRAM); `--sleep-idle-seconds 30` (unloads model after 30s idle, freeing VRAM while keeping process alive); `--fit on` (auto-fits context size to device memory)
- **NVIDIA_DRIVER_CAPABILITIES**: `compute,graphics,utility` (not `all`) — excludes `display` to prevent X11 interference on dual GPU setups
- **Restart**: never `docker rmi` unless Dockerfile changed. Only `docker rm -f mcp-llama-server` to restart with new flags. Cached images stay cached.

## Libraries (Java, all in lib/)
- Gson 2.14.0 — JSON parsing (also hand-rolled JSON-RPC 2.0 protocol)
- Guava 33.6.0-jre
- javax.annotation-api 1.3.2
- JUnit Platform Console Standalone 6.1.0 (JUnit 6 / Jupiter)

## Transport
- gRPC — primary transport for agent-to-agent and agent-to-tool communication
- JSON-RPC 2.0 over HTTP — alternative transport for MCP servers (hand-implemented, no library); HTTP ports = gRPC ports + 10

## Build
- `build.sh` — 11-step pipeline: clean → generate proto+Java → format → buf push → buf generate → generate Python stubs → compile stubs → compile main → compile tests → start servers → run tests
- Docker image `mcp-build`: Ubuntu 24.04 with Corretto 21, Node 26, Python deps, llama.cpp Vulkan binary

## Python Dependencies (in Docker / venv)
grpcio==1.81.1, grpcio-tools==1.81.1, langgraph==1.2.6, langchain-core==1.4.8, pydantic==2.13.4, typing-extensions==4.15.0
