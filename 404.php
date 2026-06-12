<?php get_header(); ?>
<main style="min-height:80vh;display:flex;flex-direction:column;align-items:center;justify-content:center;text-align:center;padding:120px 32px">
  <div style="font-size:8rem;font-family:var(--font-h);color:rgba(255,255,255,.06);line-height:1">404</div>
  <h1 style="font-family:var(--font-h);font-size:clamp(2rem,5vw,3.5rem);color:#fff;margin-bottom:16px;margin-top:-40px">Page not found.</h1>
  <p style="color:rgba(255,255,255,.5);font-size:1rem;max-width:400px;margin-bottom:40px">The page you're looking for doesn't exist or has been moved.</p>
  <a href="<?php echo esc_url(home_url('/')); ?>" class="btn-fill">← Back to Home</a>
</main>
<?php get_template_part('template-parts/footer'); wp_footer(); ?></body></html>
