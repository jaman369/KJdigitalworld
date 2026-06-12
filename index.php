<?php
/**
 * Main index template — fallback
 */
get_header();
?>
<main style="padding:120px 32px 80px;max-width:1200px;margin:0 auto">
  <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
    <article style="background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:16px;padding:40px;margin-bottom:32px">
      <h2 style="font-family:var(--font-h);font-size:1.8rem;margin-bottom:12px">
        <a href="<?php the_permalink(); ?>" style="color:#fff;text-decoration:none"><?php the_title(); ?></a>
      </h2>
      <p style="color:rgba(255,255,255,.5);font-size:.85rem;margin-bottom:16px"><?php echo get_the_date(); ?></p>
      <div style="color:rgba(255,255,255,.7)"><?php the_excerpt(); ?></div>
      <a href="<?php the_permalink(); ?>" class="btn-fill" style="margin-top:20px;display:inline-flex">Read More →</a>
    </article>
  <?php endwhile; else : ?>
    <p style="color:rgba(255,255,255,.5)">No posts found.</p>
  <?php endif; ?>
</main>
<?php
get_template_part('template-parts/footer');
wp_footer();
?>
</body>
</html>
