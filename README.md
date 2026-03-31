# OpenClaw TTS Voice Skill

免费的TTS语音生成Skill，让你的AI agent开口说话。

基于 Microsoft Edge TTS（免费，无需API key），支持十几种中英文神经语音。

## 安装

把 `tts-voice/` 目录复制到你的 OpenClaw skills 目录：

```bash
# 公共目录（所有agent可用）
cp -r tts-voice ~/.openclaw/skills/

# 或指定agent
cp -r tts-voice ~/.openclaw/workspace-<agent名>/skills/
```

## 使用

对你的AI agent说：
- "发语音"
- "语音回复"
- "念给我听"
- "用语音说"

## 语音风格

支持多种中英文语音，包括：

| 语音 | 风格 |
|------|------|
| 晓墨 XiaomoNeural | 知性沉稳女声 |
| 晓晓 XiaoxiaoNeural | 温暖自然女声 |
| 云希 YunxiNeural | 年轻自然男声 |
| 云健 YunjianNeural | 成熟播音男声 |

完整列表见 [references/voices.md](references/voices.md)

## 原理

1. 用 `node-edge-tts` 调用微软免费神经语音服务生成音频
2. 通过 OpenClaw 的 message 工具以语音消息发送到 Telegram/WhatsApp 等

## 要求

- OpenClaw（已内置 `node-edge-tts` 依赖）
- 无需任何 API key

## License

MIT
