Remove-Item .git -Recurse -Force

git init
git branch -M main
git add .
git commit -m "Initial commit"

git remote add origin https://github.com/EmrysGwynedd/Gwynedd.git
git push -u origin main --force