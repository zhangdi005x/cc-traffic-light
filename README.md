# Claude Code 桌面红绿灯 🚦

基于 [Claude-Code-Traffic-Light-Prompt](https://github.com/freed85-xiaozai/Claude-Code-Traffic-Light-Prompt) 的定制版本，适配 Windows 环境，同时适配与CursorIDE。

## 功能

| 灯色 | 状态 | 触发时机 |
|------|------|----------|
| 🔴 红灯 | 需要确认 | `PreToolUse` + `AskUserQuestion` |
| 🟡 黄灯 | 思考/执行 | `UserPromptSubmit` / `PostToolUse` |
| 🟢 绿灯 | 任务完成 | `Stop` |

## 定制内容

- 配色方案改为 Tailwind 风格（红 `#ef4444`，黄 `#facc15`，绿 `#22c55e`）
- 添加 Windows PowerShell 自动启动脚本 `set_state.ps1`
- 修复 hooks 命令在 Claude Code bash 环境中的执行问题
- 优化自动启动逻辑（检测进程而非锁文件）

## 安装

```bash
npm install
```

## 使用

### 方式一：手动启动
```bash
npx electron .
```

### 方式二：自动启动（推荐）
Claude Code 的 hooks 会在发送第一条消息时自动启动 Electron。

Hooks 配置已写入 `~/.claude/settings.json`，无需手动配置。

## 技术栈

- Electron + React + Vite + Tailwind CSS
- Web Audio API 音效（无需音频文件）
- 状态文件通信：`%TEMP%\claude-traffic-light`

## 致谢

原项目：[freed85-xiaozai/Claude-Code-Traffic-Light-Prompt](https://github.com/freed85-xiaozai/Claude-Code-Traffic-Light-Prompt)
