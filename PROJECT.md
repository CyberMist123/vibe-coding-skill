# Project Continuity Kit — 当前项目事实

> 这是本仓库的权威当前事实。所有 AI、Agent 和维护者先读本文件。
>
> 最后更新：2026-07-16

## 1. 项目目标

提供一个可复制到任意 GitHub / 本地代码项目的轻量连续性包，让不同 AI 无需反复全库审计，也不会因缺少项目框架而随意改动。

核心目标：

- 新 AI 只需从 `AGENTS.md` 进入；
- `PROJECT.md` 始终保存需求、边界、架构、接口、流程、进度与下一步；
- 已确认的代码变化自动同步回当前事实；
- 项目结束时提取跨项目可复用经验；
- 不把当前状态散落在多个 handoff、Issue、README 和聊天记录里。

## 2. 产品边界

### 做什么

- 提供新项目模板；
- 提供旧项目首次接入的 bootstrap Skill；
- 提供日常文档同步 Skill；
- 提供项目结束 closeout Skill；
- 提供安全、默认不覆盖的安装脚本；
- 维护跨项目 `LESSONS.md`。

### 不做什么

- 不代替具体项目的代码、测试、Issue 或 Git 历史；
- 不要求每次任务全库扫描；
- 不自动声称实现或验证成功；
- 不保存具体项目密钥、私密内容或绝对用户路径；
- 不建立复杂项目管理平台、数据库或外部服务；
- 不强制所有项目拥有同样的详细文档结构。

## 3. 当前架构

```text
母包仓库
├─ AGENTS.md                  母包维护入口
├─ PROJECT.md                 母包当前事实
├─ README.md                  用户使用入口
├─ INSTALL_PROMPT.md          交给 AI 的安装/合并提示
├─ LESSONS.md                 跨项目验证经验
├─ install.ps1 / install.sh   安全复制 kit
└─ kit/
   ├─ AGENTS.md               新项目 AI 入口
   ├─ PROJECT.md              新项目当前事实模板
   └─ skills/
      ├─ project-bootstrap
      ├─ project-doc-sync
      └─ project-closeout
```

## 4. 精确接口

### 安装命令

Windows：

```powershell
.\install.ps1 -TargetPath <project-path> -ProjectName <name>
```

macOS/Linux：

```bash
./install.sh <project-path> [project-name]
```

默认行为：只复制缺失文件，不覆盖已有内容。`-Force` / `--force` 才允许明确覆盖。

### 新项目 AI 入口

```text
先读根目录 AGENTS.md，按其中入口读取当前项目事实；只处理本任务，完成后执行项目文档同步。
```

### 状态枚举

- `计划中`
- `已实现/未验证`
- `已验证`
- `暂停`
- `放弃`

## 5. 文档所有权

- `PROJECT.md`：当前需求、边界、架构索引、接口、流程、进度和下一步；
- `README.md`：如何获取和使用母包；
- `INSTALL_PROMPT.md`：首次把包交给 AI 的完整提示；
- `LESSONS.md`：经过真实项目支持的跨项目经验；
- `kit/*`：复制到新项目的模板和 Skills；
- GitHub Issue：具体改进任务，不作为当前事实源。

## 6. 功能与进度

| 项目 | 状态 | 证据 / 当前事实 |
|---|---|---|
| 母包 README 与使用入口 | 已实现/未验证 | 已写入仓库，尚未由新项目完整演练 |
| 新项目 `AGENTS.md` 模板 | 已实现/未验证 | `kit/AGENTS.md` |
| 新项目 `PROJECT.md` 模板 | 已实现/未验证 | `kit/PROJECT.md` |
| project-bootstrap Skill | 已实现/未验证 | `kit/skills/project-bootstrap/SKILL.md` |
| project-doc-sync Skill | 已实现/未验证 | `kit/skills/project-doc-sync/SKILL.md` |
| project-closeout Skill | 已实现/未验证 | `kit/skills/project-closeout/SKILL.md` |
| Windows 安装脚本 | 已实现/未验证 | `install.ps1` |
| Unix 安装脚本 | 已实现/未验证 | `install.sh` |
| 可上传 ZIP | 计划中 | 生成后放入 `dist/` |
| PI OS 真实项目经验 | 已验证 | 已形成初始 `LESSONS.md` 条目 |
| 第二个独立项目迁移验证 | 计划中 | 用于确认模板通用性 |

## 7. 当前下一步

1. 完成所有模板、Skill、安装提示与脚本。
2. 生成 `dist/project-continuity-kit.zip`。
3. 读回关键文件，确认路径互相一致。
4. 在下一个真实项目首次使用后，把功能状态升级为 `已验证`。
5. 每个项目 closeout 后，只把可复用且有证据的经验合并进 `LESSONS.md`。

## 8. 更新契约

任何变化涉及目标、边界、目录结构、安装命令、Skill 行为、状态或经验库时：

1. 先更新本文件；
2. 再更新受影响的 README、模板、Skill、脚本和经验条目；
3. 删除旧描述，不能并存两套入口；
4. 没有真实运行证据时保持 `已实现/未验证`；
5. 从具体项目回收经验时，必须去除项目私密信息并说明适用范围。
