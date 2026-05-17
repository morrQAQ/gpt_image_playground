import { readRuntimeEnv } from './runtimeEnv'

export function isApiConfigHidden(): boolean {
  if (import.meta.env.MODE === 'test') return false
  return readRuntimeEnv(import.meta.env.VITE_SHOW_API_CONFIG) !== 'true'
}

export function isApiProxyAuthManaged(): boolean {
  return readRuntimeEnv(import.meta.env.VITE_API_PROXY_AUTH_MANAGED) === 'true'
}
