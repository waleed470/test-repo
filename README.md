# 🔧 Actions Hand-in (No `needs`, Strict Sequential)

Ready-made repo — bas extract karo, GitHub par push karo, aur run dekh lo.
Aapko **kuch paste/edit nahi karna**.

## What it does
- **Cascade Build & Deploy (F1→F9):** Push on `f1..f9` → current branch se le kar `f9` tak **one-by-one**:
  - Har branch me **Part1 → Part2 → Part3** ek hi job ke steps me (strict sequential), **no `needs`**.
  - Branch-level sequencing via **matrix + `max-parallel: 1`**.
- **Auto-Merger (DEV):** Push on `dev` → `dev -> f1..f9` merge **sequentially** (real merge action enabled).
- **Auto-Merger (UAT):** Push on `prod` → `prod -> uat` merge **sequentially** (real merge action enabled).
- **Serverless Part1 (demo):** Push on `f1` ya manual run.

## Quick Start
1) GitHub pe naya repo banao (Actions enabled).
2) Local me yeh chalao:
   ```bash
   git init
   git add .
   git commit -m "Init: Actions hand-in (no needs, sequential)"
   git branch -M main
   git remote add origin https://github.com/<your-user>/<your-repo>.git
   git push -u origin main
   ```
3) Branches create & push:
   ```bash
   bash scripts/create-branches.sh
   ```

## Test Triggers
- **Cascade from F1:** 
  ```bash
  git checkout f1
  echo "trigger $(date)" >> demo.txt
  git add demo.txt
  git commit -m "Trigger cascade from f1"
  git push
  ```
  It will run: `f1 (Part1→2→3)` → `f2 (Part1→2→3)` → … → `f9`

- **Cascade from F3 (earlier skip):**
  ```bash
  git checkout f3
  echo "from f3 $(date)" >> demo.txt
  git add demo.txt
  git commit -m "Trigger cascade from f3"
  git push
  ```

- **DEV Auto-Merger (real merge):** push on `dev`
- **UAT Auto-Merger (real merge):** push on `prod`

## Notes
- Kahi bhi `needs:` use nahi hua.
- Branch sequencing: matrix + `max-parallel: 1`.
- Step sequencing: single job steps (Part1→2→3) — strictly in order.
- Real merges use `${{ secrets.GITHUB_TOKEN }}` with proper `permissions`.
