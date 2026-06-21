const fs = require('fs');
const path = require('path');

const dir = '.';

// Flags replacement HTML
const newFlagsHtml = <div class="footer-flags">
  <img src="https://flagcdn.com/w20/us.png" srcset="https://flagcdn.com/w40/us.png 2x" alt="US" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/gb.png" srcset="https://flagcdn.com/w40/gb.png 2x" alt="UK" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/ca.png" srcset="https://flagcdn.com/w40/ca.png 2x" alt="CA" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/au.png" srcset="https://flagcdn.com/w40/au.png 2x" alt="AU" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/ie.png" srcset="https://flagcdn.com/w40/ie.png 2x" alt="IE" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/ae.png" srcset="https://flagcdn.com/w40/ae.png 2x" alt="AE" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/za.png" srcset="https://flagcdn.com/w40/za.png 2x" alt="ZA" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/de.png" srcset="https://flagcdn.com/w40/de.png 2x" alt="DE" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/nl.png" srcset="https://flagcdn.com/w40/nl.png 2x" alt="NL" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/nz.png" srcset="https://flagcdn.com/w40/nz.png 2x" alt="NZ" style="width:20px;height:auto;border-radius:2px;">
  <img src="https://flagcdn.com/w20/bd.png" srcset="https://flagcdn.com/w40/bd.png 2x" alt="BD" style="width:20px;height:auto;border-radius:2px;">
</div>;

function getFiles(dirPath, arrayOfFiles) {
  files = fs.readdirSync(dirPath);
  arrayOfFiles = arrayOfFiles || [];
  files.forEach(function(file) {
    if (fs.statSync(dirPath + "/" + file).isDirectory()) {
      if (file !== 'node_modules' && file !== '.git') {
        arrayOfFiles = getFiles(dirPath + "/" + file, arrayOfFiles);
      }
    } else {
      if (file.endsWith('.html')) {
        arrayOfFiles.push(path.join(dirPath, "/", file));
      }
    }
  });
  return arrayOfFiles;
}

let allFiles = getFiles(dir);

// 1. Read about.html to get the perfect footer block and the mobile menu script
let aboutContent = fs.readFileSync('about.html', 'utf8');

// The footer block matches <footer> ... </footer>
let footerMatch = aboutContent.match(/(<footer>[\s\S]*?<\/footer>)/);
let perfectFooter = footerMatch[1];

// Replace the flags in the perfect footer
perfectFooter = perfectFooter.replace(/<div class="footer-flags">.*?<\/div>/s, newFlagsHtml);

let count = 0;
for (let file of allFiles) {
  let content = fs.readFileSync(file, 'utf8');
  
  // Replace the old footer with the new perfect footer
  if (content.includes('<footer>')) {
    let newContent = content.replace(/(<footer>[\s\S]*?<\/footer>)/, perfectFooter);
    if (newContent !== content) {
      fs.writeFileSync(file, newContent, 'utf8');
      count++;
    }
  } else {
    // If no footer tag, append it before </body> or at the end
    if (content.includes('</body>')) {
      let newContent = content.replace('</body>', perfectFooter + '\n</body>');
      fs.writeFileSync(file, newContent, 'utf8');
      count++;
    }
  }
}
console.log('Successfully updated footer in ' + count + ' files.');
