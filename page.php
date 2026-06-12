<?php
/**
 * Default page template
 */
get_header();
?>
<main style="padding:120px 32px 80px;max-width:1000px;margin:0 auto">
  <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
    <h1 style="font-family:var(--font-h);font-size:clamp(2rem,5vw,3.5rem);color:#fff;margin-bottom:32px"><?php the_title(); ?></h1>
    <div style="color:rgba(255,255,255,.75);line-height:1.85"><?php the_content(); ?></div>
  <?php endwhile; endif; ?>
</main>
<?php
get_template_part('template-parts/footer');
wp_footer();
?>
</body>
</html>
