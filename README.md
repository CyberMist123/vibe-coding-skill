# Vibe Coding Project Continuity Kit

给 AI coding agent / vibe coding 项目使用的轻量项目连续性包。

它解决三个反复出现的问题：

1. 新 AI 接手时不知道项目当前做到哪里，只能重新扫仓库；
2. AI 没看到明确架构、接口和边界，随手创建第二套目录或重复实现；
3. 功能改完后代码变了，README、架构和进度仍停留在旧状态。

核心闭环：

```text
AGENTS.md          AI 的统一入口与工作纪律
    ↓
PROJECT.md         当前需求、边界、架构、接口、流程、进度与下一步
    ↓
实际代码 + 测试    证明真实实现
    ↓
project-doc-sync   完成变更后同步当前事实
    ↓
project-closeout   项目结束时提取可复用经验
    ↺
PROJECT.md / LESSONS.md
```

## 最快使用

### 方法一：把压缩包交给 AI

下载 `dist/project-continuity-kit.zip`，上传到新项目的 AI 对话，然后发送：

```text
解压并阅读这个项目连续性包。先执行 project-bootstrap，结合当前仓库和我的需求建立 AGENTS.md 与 PROJECT.md；不要覆盖已有文档，不要修改业务代码。完成后告诉我当前事实、未知项和下一步。
```

### 方法二：克隆母包后安装

Windows PowerShell：

```powershell
git clone https://github.com/CyberMist123/vibe-coding-skill.git
Set-Location .\vibe-coding-skill
.\install.ps1 -TargetPath "D:\path\to\your-project" -ProjectName "My Project"
```

macOS / Linux：

```bash
git clone https://github.com/CyberMist123/vibe-coding-skill.git
cd vibe-coding-skill
./install.sh /path/to/your-project "My Project"
```

安装脚本默认只复制缺失文件，不覆盖目标项目已有的 `AGENTS.md`、`PROJECT.md` 或 Skill。已有文件应由 AI 按 `INSTALL_PROMPT.md` 合并。

## 日常怎么对 AI 说

新任务通常只需要一句：

```text
先读根目录 AGENTS.md，按其中入口读取当前项目事实；只处理本任务，完成后执行项目文档同步。
```

在支持自动读取 `AGENTS.md` 的 coding agent 中，通常无需重复这句话。

## 包含内容

```text
kit/
├─ AGENTS.md
├─ PROJECT.md
└─ skills/
   ├─ project-bootstrap/SKILL.md
   ├─ project-doc-sync/SKILL.md
   └─ project-closeout/SKILL.md
```

- `project-bootstrap`：首次加入旧项目或新项目时，建立当前事实，不重写业务代码。
- `project-doc-sync`：功能、架构或接口变化后，纠正文档中的当前事实。
- `project-closeout`：阶段或项目结束时，冻结最终状态并提取可迁移经验。
- `LESSONS.md`：母包积累的跨项目经验，只收录真实项目验证过的规律。

## 状态语言

所有项目统一使用：

- `计划中`：需求已确认，但代码尚未实现；
- `已实现/未验证`：代码已经存在，但缺少目标环境或完整验收证据；
- `已验证`：有明确命令、测试、日志或人工 smoke 证据；
- `暂停`：暂时不继续，但仍可能恢复；
- `放弃`：明确不再实施。

文件存在不等于功能完成；测试代码存在也不等于测试通过。

## 维护原则

这个仓库是母包，不保存具体项目的私密内容。项目结束后，通过 `project-closeout` 生成一段“可迁移经验”，再由维护者审核并写入 `LESSONS.md`。不要把项目路径、密钥、用户数据或一次性事故原样搬进母包。
