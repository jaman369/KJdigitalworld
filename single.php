<?php
/**
 * Single post template
 */
get_header();
?>
<main style="padding:120px 32px 80px;max-width:860px;margin:0 auto">
  <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
    <?php if (has_post_thumbnail()) : ?>
      <div style="border-radius:16px;overflow:hidden;margin-bottom:40px">
        <?php the_post_thumbnail('blog-thumb', ['style'=>'width:100%;display:block']); ?>
      </div>
    <?php endif; ?>
    <div style="font-size:.78rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:#2563eb;margin-bottom:14px">
      <?php the_category(', '); ?>
    </div>
    <h1 style="font-family:var(--font-h);font-size:clamp(1.8rem,4vw,2.8rem);color:#fff;margin-bottom:16px;line-height:1.2"><?php the_title(); ?></h1>
    <div style="color:rgba(255,255,255,.4);font-size:.85rem;margin-bottom:40px">
      <?php echo get_the_date(); ?> · <?php echo get_the_author(); ?>
    </div>
    <div class="post-content" style="color:rgba(255,255,255,.75);line-height:1.85;font-size:1rem">
      <?php the_content(); ?>
    </div>
    <div style="margin-top:48px;padding-top:32px;border-top:1px solid rgba(255,255,255,.08)">
      <?php the_post_navigation(['prev_text'=>'← %title','next_text'=>'%title →']); ?>
    </div>
  <?php endwhile; endif; ?>
</main>
<?php
get_template_part('template-parts/footer');
wp_footer();
?>
</body>
</html>
