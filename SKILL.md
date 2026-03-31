---
name: tts-voice
description: 生成语音消息并发送给用户。支持多种中英文语音风格选择。当用户要求"发语音""语音回复""用语音说""念给我听"时触发。也适用于需要朗读长文、讲故事、开车时听回复等场景。
---

# TTS 语音生成

通过 Microsoft Edge TTS（免费，无需API key）生成语音消息并发送。

## 前置条件

- OpenClaw 已安装 `node-edge-tts` 依赖（bundled）
- 需要在 openclaw 的安装目录下执行 node 脚本以访问依赖

## 使用流程

### 1. 确定语音风格

如果用户没指定，使用当前 agent 的默认语音。如果用户要求选择语音，参考 `references/voices.md` 提供选项。

常用推荐：
- 知性女声 → `zh-CN-XiaomoNeural`（晓墨）
- 温暖女声 → `zh-CN-XiaoxiaoNeural`（晓晓）
- 年轻男声 → `zh-CN-YunxiNeural`（云希）
- 成熟男声 → `zh-CN-YunjianNeural`（云健）
- 英文女声 → `en-US-JennyNeural`
- 英文男声 → `en-US-GuyNeural`

### 2. 生成语音

在 openclaw 安装目录下执行 node 脚本：

```bash
cd /opt/homebrew/lib/node_modules/openclaw && node -e "
const { EdgeTTS } = require('node-edge-tts');
const t = new EdgeTTS();
t.ttsPromise(TEXT, OUTPUT_PATH, {voice: VOICE_ID}).then(() => {
  const fs = require('fs');
  console.log('OK', fs.statSync(OUTPUT_PATH).size);
}).catch(e => console.error('ERR:', e.message));
"
```

参数：
- `TEXT` — 要转语音的文字
- `OUTPUT_PATH` — 输出mp3文件路径（如 `/tmp/tts-output.mp3`）
- `VOICE_ID` — 语音ID（如 `zh-CN-XiaomoNeural`）

### 3. 发送语音

生成后通过 message 工具发送：

```
message(action=send, filePath=/tmp/tts-output.mp3, asVoice=true, channel=telegram, target=<chatId>)
```

### 4. 长文本处理

- 文本超过 2000 字时，先总结为 500 字以内再生成语音
- 也可以拆分为多段分别发送
- 总结时保留核心观点，用口语化表达

## 注意事项

- 优先尝试内置 `tts` 工具（`tts(text, channel)`），如果失败再用手动方式
- Microsoft Edge TTS 是免费公共服务，无SLA保证，偶尔可能超时
- 超时时重试一次，仍失败则告知用户稍后再试
- 生成的临时文件用完即删：`rm /tmp/tts-*.mp3`
