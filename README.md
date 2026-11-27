# ChemPane-GPT

Unofficial ChatGPT integration for [ChemPane](https://github.com/chempane/chempane), copyright 2026 jurimaxam-dotcom, Apache-2.0.

## Quick connection
Try the upstream remote MCP endpoint `https://mcp.chempane.com/mcp` in ChatGPT custom app settings, if your account supports custom MCP apps. This endpoint belongs to upstream, not this repository. Do not send confidential molecules until you review its privacy policy. Compatibility is not yet verified.

## Self-hosting
Deploy this repository's Dockerfile on a Docker-capable host. Set `CHEMPANE_REMOTE_ALLOWED_HOSTS` to your public hostname, configure HTTPS and access controls at the hosting layer, and connect ChatGPT to `https://YOUR-HOST/mcp`. Health check: `/healthz`. The container builds the complete upstream engine from pinned source, including its UI and licenses. No OpenAI API key is required by the engine.

Upstream revision: `ad83eee349762f52dcfa7cafec2a5719a07d327d`. This is a deployment wrapper, not a full source mirror. Interactive UI and exports require client compatibility testing. Do not expose an unauthenticated service for private data.
