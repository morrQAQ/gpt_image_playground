/// <reference types="vite/client" />

declare const __APP_VERSION__: string
declare const __DEV_PROXY_CONFIG__: unknown

interface ImportMetaEnv {
  readonly VITE_DEFAULT_API_URL?: string
  readonly VITE_DEFAULT_API_MODE?: string
  readonly VITE_DEFAULT_MODEL?: string
  readonly VITE_DEFAULT_CODEX_CLI?: string
  readonly VITE_DEFAULT_REASONING_EFFORT?: string
  readonly VITE_DISABLE_RESPONSE_STORAGE?: string
  readonly VITE_API_PROXY_AVAILABLE?: string
  readonly VITE_API_PROXY_LOCKED?: string
  readonly VITE_API_PROXY_AUTH_MANAGED?: string
  readonly VITE_HIDE_API_CONFIG?: string
  readonly VITE_SHOW_API_CONFIG?: string
  readonly VITE_DOCKER_DEPLOYMENT?: string
  readonly VITE_DOCKER_LEGACY_API_URL_USED?: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
