import re

with open('lovable_blog.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove lovable scripts and badge
content = re.sub(r'<aside\s+id="lovable-badge".*?</aside>', '', content, flags=re.DOTALL)
content = re.sub(r'<script class="\$tsr".*?</script>', '', content, flags=re.DOTALL)
content = re.sub(r'<script type="module" async="">.*?</script>', '', content, flags=re.DOTALL)
content = re.sub(r'<script defer src="/~flock\.js".*?</script>', '', content, flags=re.DOTALL)
content = re.sub(r'<script defer src="/__l5e/events\.js".*?</script>', '', content, flags=re.DOTALL)

# Add category filtering
filter_script = """
<script>
  // Category Filtering Logic
  document.addEventListener('DOMContentLoaded', () => {
    const filterChips = document.querySelectorAll('.filter-chip');
    const posts = document.querySelectorAll('.post-card, .featured-card');

    filterChips.forEach(chip => {
      chip.addEventListener('click', () => {
        // Remove active class from all chips
        filterChips.forEach(c => c.classList.remove('active'));
        // Add active class to clicked chip
        chip.classList.add('active');

        const category = chip.getAttribute('data-cat');

        posts.forEach(post => {
          if (category === 'all' || post.getAttribute('data-cat') === category) {
            post.style.display = '';
          } else {
            post.style.display = 'none';
          }
        });
      });
    });
  });
</script>
</body>
</html>
"""

# replace the closing tags safely
content = re.sub(r'</body>\s*</html>', filter_script, content, flags=re.DOTALL)

with open('blog.html', 'w', encoding='utf-8') as f:
    f.write(content)
