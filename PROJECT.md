# Project Continuity Kit — 当前项目事实

> 这是本仓库的权威当前事实。所有 AI、Agent 和维护者先读本文件。
>
> 最后更新：2026-07-17

## 1. 项目目标

提供一个可复制到任意 GitHub / 本地代码项目的轻量连续性包，让不同 AI 无需反复全库审计，也不会因缺少项目框架而随意改动。

核心目标：

- 新 AI 只需从 `AGENTS.md` 进入；
- `PROJECT.md` 始终保存需求、边界、架构、接口、流程、进度与下一步；
- 已确认的代码变化同步回当前事实；
- 项目结束时提取跨项目可复用经验；
- 不把当前状态散落在多个 handoff、Issue、README 和聊天记录里。

## 2. 产品边界

### 做什么

- 提供新项目模板；
- 提供旧项目首次接入的 bootstrap Skill；
- 提供日常文档同步 Skill；
- 提供项目结束 closeout Skill；
- 提供安全、默认不覆盖的安装脚本；
- 提供可重建的精简 ZIP；
- 维护跨项目 `LESSONS.md`。

### 不做什么

- 不代替具体项目的代码、测试、Issue 或 Git 历史；
- 不要求每次任务全库扫描；
- 不自动声称实现或验证成功；
- 不保存具体项目密钥、私密内容或绝对用户路径；
- 不建立复杂项目管理平台、数据库或外部服务；
- 不强制所有项目拥有同样的详细文档结构；
- 不把生成的 ZIP 当作唯一事实，仓库文本始终是源。

## 3. 当前架构

```text
母包仓库
├─ AGENTS.md                    母包维护入口
├─ PROJECT.md                   母包当前事实
├─ README.md                    用户使用入口
├─ INSTALL_PROMPT.md            交给 AI 的安装/合并提示
├─ LESSONS.md                   跨项目验证经验
├─ VERSION                      母包版本
├─ install.ps1 / install.sh     安全复制 kit
├─ build-package.ps1 / .sh      从当前源生成精简 ZIP
└─ kit/
   ├─ AGENTS.md                 新项目 AI 入口
   ├─ PROJECT.md                新项目当前事实模板
   └─ skills/
      ├─ project-bootstrap
      ├─ project-doc-sync
      └─ project-closeout
```

当前源版本：`0.1.2`。

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

默认只复制缺失文件，不覆盖已有内容。`-Force` / `--force` 才允许明确覆盖。

### 构建精简包

Windows：

```powershell
.\build-package.ps1
```

macOS/Linux：

```bash
./build-package.sh
```

输出：

```text
dist/project-continuity-kit.zip
```

ZIP 包含 `VERSION`、`kit/`、`INSTALL_PROMPT.md`、`LESSONS.md`、README 和安装脚本。生成物可删除并从 Git 源重新构建。

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
- `README.md`：如何获取、构建和使用母包；
- `INSTALL_PROMPT.md`：首次把包交给 AI 的完整提示；
- `LESSONS.md`：经过真实项目支持的跨项目经验；
- `kit/*`：复制到新项目的模板和 Skills；
- GitHub Issue：具体改进任务，不作为当前事实源；
- `dist/*.zip`：可重建发布物，不作为模板源。

## 6. 首个项目闭环结果

2026-07-17，首个真实项目完成从设计、跨窗口接手、目标环境部署、分能力验收到 closeout 的完整闭环：

```text
AGENTS.md
→ PROJECT.md
→ 相关代码和运维文档
→ 真实目标环境执行
→ 按能力更新验证状态
→ 删除过期规划/审核/handoff 文档
→ 关闭基础部署 Issue
→ 回收去隐私的跨项目经验
```

此次 closeout 验证了：

- 权威项目事实可支持跨窗口接手；
- 进度可以按能力和证据逐项升级；
- 完成后可删除过程稿而保留运行脚本和当前文档；
- 可将原生命令 stderr、分层开机启动等真实故障提炼为通用经验；
- 项目私密路径、域名、密钥和内容没有进入母包经验库。

## 7. 功能与进度

| 项目 | 状态 | 证据 / 当前事实 |
|---|---|---|
| 母包 README 与使用入口 | 已实现/未验证 | 尚未由第二个独立项目完整演练 |
| 新项目 `AGENTS.md` 模板 | 已实现/未验证 | `kit/AGENTS.md` |
| 新项目 `PROJECT.md` 模板 | 已实现/未验证 | `kit/PROJECT.md` |
| project-bootstrap Skill | 已实现/未验证 | 尚未在第二个独立项目执行 |
| project-doc-sync Skill | 已验证 | 首个项目中多次按真实差量同步 PROJECT、文档与 Issue |
| project-closeout Skill | 已验证 | 首个项目完成最终状态冻结、过程稿清理和经验回收 |
| Windows 安装脚本 | 已实现/未验证 | 尚未在第二个项目通过母包安装执行 |
| Unix 安装脚本 | 已实现/未验证 | 尚未在真实目标项目运行 |
| Windows/Unix 构建脚本 | 已实现/未验证 | 可构建 ZIP，仍待独立本机演练 |
| 旧版可上传 ZIP | 已验证 | `0.1.1` ZIP 已生成并校验；源已升级到 `0.1.2`，下次使用前重建 |
| 跨窗口 Agent 接手路径 | 已验证 | 新执行窗口从仓库入口接手并完成真实部署 |
| 验证状态按能力切片 | 已验证 | 直到媒体、备份、重启恢复逐项通过才关闭阶段 |
| 首个项目 closeout | 已验证 | 权威文档收口、过程稿删除、Issue 关闭、经验回收完成 |
| 第二个独立项目迁移验证 | 计划中 | 验证 bootstrap、安装/合并和通用 doc-sync 的跨项目适用性 |

## 8. 当前下一步

1. 从当前 `0.1.2` 文本源重建新的精简 ZIP；
2. 在第二个真实项目中安装或上传该包；
3. 验证 bootstrap 不覆盖已有文档或修改业务代码；
4. 完成一次真实功能修改并执行 doc-sync；
5. 项目结束时再次执行 closeout，比较哪些经验真正跨项目成立。

## 9. 更新契约

任何变化涉及目标、边界、目录结构、安装/构建命令、Skill 行为、状态或经验库时：

1. 先更新本文件；
2. 再更新受影响的 README、模板、Skill、脚本和经验条目；
3. 删除旧描述，不能并存两套入口；
4. 没有真实运行证据时保持 `已实现/未验证`；
5. 从具体项目回收经验时，必须去除项目私密信息并说明适用范围；
6. 发布 ZIP 必须可从当前 Git 文本源重建并给出校验值。
