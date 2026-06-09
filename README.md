# Claude Code 桌面红绿灯 🚦

基于 [Claude-Code-Traffic-Light-Prompt](https://github.com/freed85-xiaozai/Claude-Code-Traffic-Light-Prompt) 的定制版本，**适配 Windows 环境 + Cursor IDE**。

## 功能

| 灯色 | 状态 | Claude Code 触发 | Cursor IDE 触发 |
|------|------|------------------|-----------------|
| 🔴 红灯 | 需要确认 | `AskUserQuestion` / `Bash` / `Write` / `Edit`（需要权限时） | AI 编辑确认弹窗 |
| 🟡 黄灯 | 思考/执行 | `UserPromptSubmit` / `PostToolUse` | - |
| 🟢 绿灯 | 任务完成 | `Stop` | - |

## 定制内容

### Windows 适配
- 配色方案改为 Tailwind 风格（红 `#ef4444`，黄 `#facc15`，绿 `#22c55e`）
- 添加 Windows PowerShell 自动启动脚本 `set_state.ps1`
- 修复 hooks 命令在 Claude Code bash 环境中的执行问题（`cmd /c` → `powershell`）
- 优化自动启动逻辑（检测进程而非锁文件）
- 音效自动播放（`autoplayPolicy: 'no-user-gesture-required'`）

### Cursor IDE 支持
- 创建 VS Code 扩展检测 Cursor AI 编辑确认弹窗
- 当 Cursor 弹出 "Do you want to make this edit?" 时自动切换红灯
- 扩展仓库：[cursor-traffic-light](https://github.com/zhangdi005x/cursor-traffic-light)

## 安装

```bash
npm install
```

## 使用

### Claude Code
Hooks 配置已写入 `~/.claude/settings.json`，发送第一条消息时自动启动 Electron。

配置示例见 `settings.example.json`，包含以下 hooks：
- `UserPromptSubmit` → 黄灯（用户发送消息）
- `PostToolUse` → 黄灯（工具执行完成）
- `Stop` → 绿灯（任务完成）
- `PreToolUse` + `AskUserQuestion/Bash/Write/Edit` → 红灯（需要确认）

### Cursor IDE
1. 安装 [cursor-traffic-light](https://github.com/zhangdi005x/cursor-traffic-light) 扩展
2. 重启 Cursor
3. 当 Cursor AI 编辑代码时，红灯自动亮起

### 手动启动
```bash
npx electron .
```

## 技术栈

- Electron + React + Vite + Tailwind CSS
- Web Audio API 音效（无需音频文件）
- VS Code Extension API（Cursor 扩展）
- 状态文件通信：`%TEMP%\claude-traffic-light`

## 相关仓库

| 仓库 | 说明 |
|------|------|
| [cc-traffic-light](https://github.com/zhangdi005x/cc-traffic-light) | 桌面红绿灯 Electron 应用 |
| [cursor-traffic-light](https://github.com/zhangdi005x/cursor-traffic-light) | Cursor IDE 扩展 |

## 致谢

原项目：[freed85-xiaozai/Claude-Code-Traffic-Light-Prompt](https://github.com/freed85-xiaozai/Claude-Code-Traffic-Light-Prompt)
