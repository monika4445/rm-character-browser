set -e
npm run build
cd dist
git init 
git add -A
git commit -m "New Deployment"
git push -f git@github.com:monika4445/rm-character-browser.git master:gh-pages
cd -