import os
import re
import glob

footer_html = """<footer>
  <div class="footer-w">
    <div class="footer-top">
      <div>
        <div class="footer-brand">Digital World</div>
        <p class="footer-tagline">Full-Service Digital Marketing Agency · 5 Years Experience · Serving 11 countries worldwide.</p>
        <div class="footer-flags">
  <img src="https://flagcdn.com/w20/us.png" srcset="https://flagcdn.com/w40/us.png 2x" alt="US" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/gb.png" srcset="https://flagcdn.com/w40/gb.png 2x" alt="UK" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ca.png" srcset="https://flagcdn.com/w40/ca.png 2x" alt="CA" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/au.png" srcset="https://flagcdn.com/w40/au.png 2x" alt="AU" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ie.png" srcset="https://flagcdn.com/w40/ie.png 2x" alt="IE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ae.png" srcset="https://flagcdn.com/w40/ae.png 2x" alt="AE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/za.png" srcset="https://flagcdn.com/w40/za.png 2x" alt="ZA" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/de.png" srcset="https://flagcdn.com/w40/de.png 2x" alt="DE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/nl.png" srcset="https://flagcdn.com/w40/nl.png 2x" alt="NL" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/nz.png" srcset="https://flagcdn.com/w40/nz.png 2x" alt="NZ" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/bd.png" srcset="https://flagcdn.com/w40/bd.png 2x" alt="BD" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
</div>
        <div class="footer-social">
          <a href="https://www.facebook.com/digitalworld1988" class="footer-soc-link" target="_blank" rel="noopener" title="Facebook" aria-label="Facebook">f</a>
          <a href="https://www.instagram.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Instagram" aria-label="Instagram">ig</a>
          <a href="https://x.com/" class="footer-soc-link" target="_blank" rel="noopener" title="X (Twitter)" aria-label="X">𝕏</a>
          <a href="https://www.pinterest.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Pinterest" aria-label="Pinterest">P</a>
          <a href="https://www.youtube.com/" class="footer-soc-link" target="_blank" rel="noopener" title="YouTube" aria-label="YouTube">▶</a>
          <a href="https://www.indeed.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Indeed" aria-label="Indeed">in</a>
          <a href="https://www.linkedin.com/in/kamrujjaman-mufti/" class="footer-soc-link" target="_blank" rel="noopener" title="LinkedIn" aria-label="LinkedIn">Li</a>
        </div>
        <a href="/contact" style="display:inline-block;margin-top:18px;background:var(--blue,#0071e3);color:#fff;font-size:12px;font-weight:500;padding:10px 18px;border-radius:980px;text-decoration:none;">📅 Book Free Consultation</a>
      </div>
      <div class="footer-col" style="padding-top: 10px;">
        <a class="footer-link" href="/services/seo#svc-local">Local SEO</a>
        <a class="footer-link" href="/services/seo#svc-ecom">Ecommerce SEO</a>
        <a class="footer-link" href="/services/seo#svc-intl">International SEO</a>
        <a class="footer-link" href="/services/seo#svc-saas">SaaS SEO</a>
        <a class="footer-link" href="/services/seo#svc-semantic">Semantic SEO</a>
      </div>
      <div class="footer-col" style="padding-top: 10px;">
        <a class="footer-link" href="/services/web#svc-wordpress">WordPress Development</a>
        <a class="footer-link" href="/services/web#svc-shopify">Shopify Development</a>
        <a class="footer-link" href="/services/ppc#svc-search">Google Ads / PPC</a>
        <a class="footer-link" href="/services/ppc#svc-facebook">Facebook &amp; Instagram Ads</a>
        <a class="footer-link" href="/services/content#svc-content">Content Marketing</a>
      </div>
      <div class="footer-col" style="padding-top: 10px;">
        <a href="/about" class="footer-link">About Us</a>
        <a href="/portfolio" class="footer-link">Portfolio</a>
        <a href="/blog" class="footer-link">Blog</a>
        <a class="footer-link" href="/contact">Contact</a>
        <a class="footer-link" href="mailto:kj.jaman369@gmail.com">kj.jaman369@gmail.com</a>
        <a class="footer-link" href="tel:+8801798667820">+880 1798-667820</a>
      </div>
    </div>
    <div class="footer-bottom">
      <p class="footer-copy">Copyright © 2025 Digital World · Kamrujjaman Mufti. All rights reserved.</p>
      <p class="footer-copy">Based in Dhaka, Bangladesh · Available worldwide</p>
    </div>
  </div>
</footer>
<style>
.wa-float {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 56px;
  height: 56px;
  background-color: #25d366;
  color: #fff;
  border-radius: 50px;
  text-align: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.wa-float:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0,0,0,0.2);
}
.wa-icon {
  width: 32px;
  height: 32px;
}
</style>
<a href="https://wa.me/8801798667820?text=Hi%20KJ%20Digital%20World%2C%20I%20am%20interested%20in%20your%20services" class="wa-float" target="_blank" rel="noopener noreferrer" aria-label="Chat on WhatsApp"><svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg" class="wa-icon"><path d="M16 2C8.268 2 2 8.268 2 16c0 2.585.69 5.003 1.895 7.1L2 30l7.1-1.895A13.94 13.94 0 0016 30c7.732 0 14-6.268 14-14S23.732 2 16 2zm7.397 9.865l-1.265 5.975c-.095.425-.488.725-.923.725-.085 0-.17-.01-.252-.03l-2.42-.63a9.87 9.87 0 01-4.21 1.045c-5.465 0-9.9-4.435-9.9-9.9 0-.48.034-.955.102-1.42.13-.93.914-1.6 1.854-1.6h.08c.46.02.89.23 1.17.57l1.59 1.98c.37.46.33 1.12-.09 1.53l-.79.77c-.27.26-.34.66-.17 1 .47.94 1.15 1.76 1.99 2.41.35.27.83.27 1.17.03l1.02-.78c.44-.34 1.06-.32 1.48.04l2.01 1.73c.37.32.5.82.33 1.27z" fill="currentColor"></path></svg></a>"""

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the footer
    # Using regex to match <footer>...</footer>
    new_content = re.sub(r'<footer\b[^>]*>.*?</footer>', footer_html, content, flags=re.DOTALL)
    
    # Remove existing wa-float tag and any </div><!--/$--> if it was paired with it in lovable files
    # The lovable files have: </div><!--/$--><a href="..." class="wa-float" ...>...</a>
    # We'll first just remove the <a class="wa-float" ...>...</a> part, and any trailing whitespace
    # If there's an existing one, the new content will have two of them (one from footer_html, one old one).
    # Wait, it's easier to first strip out existing wa-floats BEFORE applying the footer_html,
    # OR after applying footer_html we remove ALL wa-floats and append ONE at the very end of footer.
    # But wait, footer_html already includes it.
    
    # Remove the OLD ones before we replace footer.
    # The old ones look like: <a href="https://wa.me/... class="wa-float" ... </a>
    content_no_wa = re.sub(r'<a[^>]*class="wa-float"[^>]*>.*?</a>', '', content, flags=re.DOTALL)
    
    # Also remove any inline style block that contains .wa-float just to be clean
    content_no_wa = re.sub(r'<style>\s*\.wa-float\s*\{.*?</style>', '', content_no_wa, flags=re.DOTALL)
    
    # Also remove lovable extra tags like `</div><!--/$-->` if they were just floating? 
    # Actually, those `</div><!--/$-->` are part of NextJS/React hydration wrappers, they shouldn't be removed, or we will break the HTML structure. The wa-float was just appended.
    # The `content_no_wa` still has the old `<footer>`
    
    new_content = re.sub(r'<footer\b[^>]*>.*?</footer>', footer_html, content_no_wa, flags=re.DOTALL)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated: {filepath}")

if __name__ == "__main__":
    for filepath in glob.glob("*.html"):
        if filepath != "temp.html":  # ignore temp.html as it's generated? Actually it's fine to update it, but let's just do it
            process_file(filepath)
