#!/bin/sh

# 用环境变量替换前端默认 API URL
DEFAULT_API_URL=${DEFAULT_API_URL:-${API_URL:-https://api.openai.com/v1}}
DOCKER_LEGACY_API_URL_USED=${DOCKER_LEGACY_API_URL_USED:-false}
if [ -n "$API_URL" ]; then
    DOCKER_LEGACY_API_URL_USED=true
fi

API_PROXY_AVAILABLE=false
if [ "$ENABLE_API_PROXY" = "true" ]; then
    API_PROXY_AVAILABLE=true
fi

API_PROXY_LOCKED=false
if [ "$ENABLE_API_PROXY" = "true" ] && [ "$LOCK_API_PROXY" = "true" ]; then
    API_PROXY_LOCKED=true
fi

API_PROXY_AUTH_MANAGED=false
if [ -n "$API_PROXY_API_KEY" ]; then
    API_PROXY_AUTH_MANAGED=true
fi

HIDE_API_CONFIG=${HIDE_API_CONFIG:-false}
SHOW_API_CONFIG=${SHOW_API_CONFIG:-false}
DEFAULT_API_MODE=${DEFAULT_API_MODE:-images}
DEFAULT_MODEL=${DEFAULT_MODEL:-gpt-image-2}
DEFAULT_API_TIMEOUT=${DEFAULT_API_TIMEOUT:-600}
DEFAULT_CODEX_CLI=${DEFAULT_CODEX_CLI:-false}
DEFAULT_REASONING_EFFORT=${DEFAULT_REASONING_EFFORT:-}
DISABLE_RESPONSE_STORAGE=${DISABLE_RESPONSE_STORAGE:-false}
RESPONSES_STREAM=${RESPONSES_STREAM:-false}
RESPONSES_PARTIAL_IMAGES=${RESPONSES_PARTIAL_IMAGES:-1}

# 查找所有 js 文件并将占位符替换为运行时配置
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_API_URL_PLACEHOLDER__|$DEFAULT_API_URL|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_API_MODE_PLACEHOLDER__|$DEFAULT_API_MODE|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_MODEL_PLACEHOLDER__|$DEFAULT_MODEL|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_API_TIMEOUT_PLACEHOLDER__|$DEFAULT_API_TIMEOUT|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_CODEX_CLI_PLACEHOLDER__|$DEFAULT_CODEX_CLI|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DEFAULT_REASONING_EFFORT_PLACEHOLDER__|$DEFAULT_REASONING_EFFORT|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DISABLE_RESPONSE_STORAGE_PLACEHOLDER__|$DISABLE_RESPONSE_STORAGE|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_RESPONSES_STREAM_PLACEHOLDER__|$RESPONSES_STREAM|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_RESPONSES_PARTIAL_IMAGES_PLACEHOLDER__|$RESPONSES_PARTIAL_IMAGES|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_API_PROXY_AVAILABLE_PLACEHOLDER__|$API_PROXY_AVAILABLE|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_API_PROXY_LOCKED_PLACEHOLDER__|$API_PROXY_LOCKED|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_API_PROXY_AUTH_MANAGED_PLACEHOLDER__|$API_PROXY_AUTH_MANAGED|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_HIDE_API_CONFIG_PLACEHOLDER__|$HIDE_API_CONFIG|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_SHOW_API_CONFIG_PLACEHOLDER__|$SHOW_API_CONFIG|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DOCKER_DEPLOYMENT_PLACEHOLDER__|true|g" {} +
find /usr/share/nginx/html/assets -type f -name "*.js" -exec sed -i "s|__VITE_DOCKER_LEGACY_API_URL_USED_PLACEHOLDER__|$DOCKER_LEGACY_API_URL_USED|g" {} +

# 检查是否启用了 API 代理
if [ "$ENABLE_API_PROXY" != "true" ]; then
    # 删除代理配置块
    sed -i '/# BEGIN API PROXY/,/# END API PROXY/d' /etc/nginx/conf.d/default.conf
fi

exec "$@"
