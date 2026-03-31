#!/bin/bash
# TTS语音生成脚本
# 用法: tts_generate.sh "要说的文字" [输出文件] [语音ID]
# 示例: tts_generate.sh "你好" /tmp/hello.mp3 zh-CN-XiaomoNeural

TEXT="${1:?用法: tts_generate.sh \"文字\" [输出文件] [语音ID]}"
OUTPUT="${2:-/tmp/tts-output.mp3}"
VOICE="${3:-zh-CN-XiaomoNeural}"

OPENCLAW_DIR="$(npm root -g 2>/dev/null)/openclaw"
if [ ! -d "$OPENCLAW_DIR" ]; then
  OPENCLAW_DIR="/opt/homebrew/lib/node_modules/openclaw"
fi

node -e "
const { EdgeTTS } = require('node-edge-tts');
const t = new EdgeTTS();
const text = process.argv[1];
const output = process.argv[2];
const voice = process.argv[3];
t.ttsPromise(text, output, {voice}).then(() => {
  const fs = require('fs');
  const size = fs.statSync(output).size;
  console.log(JSON.stringify({ok: true, file: output, voice, size}));
}).catch(e => {
  console.error(JSON.stringify({ok: false, error: e.message}));
  process.exit(1);
});
" "$TEXT" "$OUTPUT" "$VOICE" --prefix "$OPENCLAW_DIR"

# 注意：需要在 openclaw 的 node_modules 目录下运行，或设置 NODE_PATH
