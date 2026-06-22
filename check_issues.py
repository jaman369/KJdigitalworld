import os
from html.parser import HTMLParser

class IssueChecker(HTMLParser):
    def __init__(self, filepath):
        super().__init__()
        self.filepath = filepath
        self.links = []
        self.images = []
        self.has_title = False
        self.has_meta_desc = False

    def handle_starttag(self, tag, attrs):
        attrs_dict = dict(attrs)
        if tag == 'a' and 'href' in attrs_dict:
            self.links.append(attrs_dict['href'])
        if tag == 'img' and 'src' in attrs_dict:
            self.images.append(attrs_dict['src'])
        if tag == 'link' and 'href' in attrs_dict:
            self.links.append(attrs_dict['href'])
        if tag == 'script' and 'src' in attrs_dict:
            self.links.append(attrs_dict['src'])
        if tag == 'title':
            self.has_title = True
        if tag == 'meta':
            if attrs_dict.get('name') == 'description':
                self.has_meta_desc = True

def check_files():
    issues = []
    html_files = [f for f in os.listdir('.') if f.endswith('.html')]
    
    for f in html_files:
        try:
            with open(f, 'r', encoding='utf-8') as file:
                content = file.read()
                
            parser = IssueChecker(f)
            parser.feed(content)
            
            if not parser.has_title:
                issues.append(f"{f}: Missing <title> tag")
            if not parser.has_meta_desc:
                issues.append(f"{f}: Missing meta description")
                
            for link in parser.links:
                if link.startswith('http') or link.startswith('#') or link.startswith('mailto:') or link.startswith('tel:'):
                    continue
                # Remove query params or fragments
                clean_link = link.split('?')[0].split('#')[0]
                if clean_link.startswith('/'):
                    clean_link = clean_link[1:]
                
                # if the link points to a directory, assume index.html
                if not clean_link:
                    continue
                
                if not os.path.exists(clean_link):
                    issues.append(f"{f}: Broken link/asset -> {link}")
                    
            for img in parser.images:
                if img.startswith('http') or img.startswith('data:'):
                    continue
                clean_img = img.split('?')[0].split('#')[0]
                if clean_img.startswith('/'):
                    clean_img = clean_img[1:]
                if not os.path.exists(clean_img):
                    issues.append(f"{f}: Missing image -> {img}")
                    
        except Exception as e:
            issues.append(f"Error parsing {f}: {e}")

    with open('issues.txt', 'w', encoding='utf-8') as out:
        for issue in issues:
            out.write(issue + '\n')

if __name__ == '__main__':
    check_files()
