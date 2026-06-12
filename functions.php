<?php
/**
 * Digital World Theme Functions (v2)
 */

if ( ! defined( 'ABSPATH' ) ) exit;

define( 'DW_VERSION', '2.0.0' );
define( 'DW_DIR', get_template_directory() );
define( 'DW_URI', get_template_directory_uri() );

/* ─── Theme Setup ─── */
function dw_setup() {
    add_theme_support( 'title-tag' );
    add_theme_support( 'post-thumbnails' );
    add_theme_support( 'html5', ['search-form','comment-form','comment-list','gallery','caption'] );
    add_theme_support( 'custom-logo', [
        'height' => 60, 'width' => 200, 'flex-height' => true, 'flex-width' => true,
    ]);
    add_theme_support( 'menus' );
    add_theme_support( 'responsive-embeds' );
    register_nav_menus([
        'primary' => __( 'Primary Menu', 'digitalworld' ),
        'footer'  => __( 'Footer Menu', 'digitalworld' ),
    ]);
    load_theme_textdomain( 'digitalworld', DW_DIR . '/languages' );
}
add_action( 'after_setup_theme', 'dw_setup' );

/* ─── Enqueue Styles & Scripts ─── */
function dw_assets() {
    wp_enqueue_style( 'dw-fonts',
        'https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500;600&display=swap',
        [], null );

    wp_enqueue_style( 'dw-style', DW_URI . '/assets/css/main.css', ['dw-fonts'], DW_VERSION );

    wp_enqueue_script( 'dw-main', DW_URI . '/assets/js/main.js', [], DW_VERSION, true );

    wp_localize_script( 'dw-main', 'dw_ajax', [
        'url'   => admin_url( 'admin-ajax.php' ),
        'nonce' => wp_create_nonce( 'dw_nonce' ),
    ]);

    if ( is_singular() && comments_open() ) {
        wp_enqueue_script( 'comment-reply' );
    }
}
add_action( 'wp_enqueue_scripts', 'dw_assets' );

/* ─── Remove WP bloat ─── */
remove_action( 'wp_head', 'print_emoji_detection_script', 7 );
remove_action( 'wp_print_styles', 'print_emoji_styles' );
remove_action( 'wp_head', 'wp_generator' );
remove_action( 'wp_head', 'wlwmanifest_link' );
remove_action( 'wp_head', 'rsd_link' );

/* ─── Custom Post Types ─── */
function dw_register_cpts() {
    register_post_type( 'portfolio', [
        'labels' => [
            'name'          => __( 'Portfolio', 'digitalworld' ),
            'singular_name' => __( 'Portfolio Item', 'digitalworld' ),
            'add_new_item'  => __( 'Add New Portfolio Item', 'digitalworld' ),
        ],
        'public'       => true,
        'has_archive'  => true,
        'show_in_rest' => true,
        'menu_icon'    => 'dashicons-portfolio',
        'supports'     => ['title','editor','thumbnail','excerpt','custom-fields'],
        'rewrite'      => ['slug' => 'portfolio-item'],
    ]);

    register_post_type( 'testimonial', [
        'labels' => [
            'name'          => __( 'Testimonials', 'digitalworld' ),
            'singular_name' => __( 'Testimonial', 'digitalworld' ),
        ],
        'public'       => false,
        'show_ui'      => true,
        'show_in_rest' => true,
        'menu_icon'    => 'dashicons-format-quote',
        'supports'     => ['title','editor','custom-fields'],
    ]);
}
add_action( 'init', 'dw_register_cpts' );

/* ─── Custom Taxonomies ─── */
function dw_register_taxonomies() {
    register_taxonomy( 'portfolio_cat', 'portfolio', [
        'labels'       => ['name' => __( 'Portfolio Categories', 'digitalworld' )],
        'hierarchical' => true,
        'show_in_rest' => true,
        'rewrite'      => ['slug' => 'portfolio-category'],
    ]);
}
add_action( 'init', 'dw_register_taxonomies' );

/* ─── Customizer Settings ─── */
function dw_customizer( $wp_customize ) {
    $wp_customize->add_panel( 'dw_agency', [
        'title'    => __( 'Agency Settings', 'digitalworld' ),
        'priority' => 30,
    ]);

    /* Contact Info */
    $wp_customize->add_section( 'dw_contact_info', [
        'title' => __( 'Contact Information', 'digitalworld' ),
        'panel' => 'dw_agency',
    ]);
    $fields = [
        'dw_email'    => ['label' => 'Email Address',    'default' => 'kj.jaman369@gmail.com'],
        'dw_phone'    => ['label' => 'Phone / WhatsApp Display', 'default' => '+880 1798-667820'],
        'dw_whatsapp' => ['label' => 'WhatsApp Number (digits only)', 'default' => '8801798667820'],
        'dw_location' => ['label' => 'Location',         'default' => 'Dhaka, Bangladesh (Remote)'],
        'dw_linkedin' => ['label' => 'LinkedIn URL',     'default' => 'https://linkedin.com/in/kamrujjaman-mufti'],
        'dw_facebook' => ['label' => 'Facebook URL',     'default' => 'https://facebook.com/digitalworld1988'],
    ];
    foreach ( $fields as $id => $args ) {
        $wp_customize->add_setting( $id, ['default' => $args['default'], 'sanitize_callback' => 'sanitize_text_field'] );
        $wp_customize->add_control( $id, ['label' => $args['label'], 'section' => 'dw_contact_info', 'type' => 'text'] );
    }

    /* Hero Section */
    $wp_customize->add_section( 'dw_hero', [
        'title' => __( 'Homepage Hero', 'digitalworld' ),
        'panel' => 'dw_agency',
    ]);
    $wp_customize->add_setting( 'dw_hero_line1', ['default' => 'Grow your business', 'sanitize_callback' => 'sanitize_text_field'] );
    $wp_customize->add_control( 'dw_hero_line1', ['label' => 'Hero Line 1', 'section' => 'dw_hero', 'type' => 'text'] );

    $wp_customize->add_setting( 'dw_hero_line2', ['default' => 'beyond borders', 'sanitize_callback' => 'sanitize_text_field'] );
    $wp_customize->add_control( 'dw_hero_line2', ['label' => 'Hero Line 2 (accent colour)', 'section' => 'dw_hero', 'type' => 'text'] );

    $wp_customize->add_setting( 'dw_hero_sub', ['default' => 'Digital World is a full-service digital marketing agency helping businesses in the USA, UK, Canada, UAE, Australia & beyond dominate search, ads, and the web — led by Kamrujjaman Mufti.', 'sanitize_callback' => 'sanitize_textarea_field'] );
    $wp_customize->add_control( 'dw_hero_sub', ['label' => 'Hero Subtext', 'section' => 'dw_hero', 'type' => 'textarea'] );
}
add_action( 'customize_register', 'dw_customizer' );

/* ─── Helper: get theme option ─── */
function dw_opt( $key, $fallback = '' ) {
    return get_theme_mod( $key, $fallback );
}

/* ─── Excerpt customisation ─── */
add_filter( 'excerpt_length', fn() => 24 );
add_filter( 'excerpt_more', fn() => '...' );

/* ─── Widget Areas ─── */
function dw_widgets() {
    register_sidebar([
        'name'          => __( 'Blog Sidebar', 'digitalworld' ),
        'id'            => 'blog-sidebar',
        'before_widget' => '<div class="widget">',
        'after_widget'  => '</div>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ]);
}
add_action( 'widgets_init', 'dw_widgets' );

/* ─── Contact Form AJAX Handler ─── */
function dw_handle_contact() {
    check_ajax_referer( 'dw_nonce', 'nonce' );

    $name    = sanitize_text_field( $_POST['name'] ?? '' );
    $email   = sanitize_email( $_POST['email'] ?? '' );
    $company = sanitize_text_field( $_POST['company'] ?? '' );
    $country = sanitize_text_field( $_POST['country'] ?? '' );
    $service = sanitize_text_field( $_POST['service'] ?? '' );
    $budget  = sanitize_text_field( $_POST['budget'] ?? '' );
    $message = sanitize_textarea_field( $_POST['message'] ?? '' );

    if ( ! $name || ! is_email( $email ) || ! $message ) {
        wp_send_json_error( ['message' => 'Please fill in all required fields.'] );
    }

    $to      = get_option( 'admin_email' );
    $subject = "New project enquiry from {$name} — Digital World";
    $body  = "Name: {$name}\n";
    $body .= "Email: {$email}\n";
    $body .= "Company: {$company}\n";
    $body .= "Country: {$country}\n";
    $body .= "Service Needed: {$service}\n";
    $body .= "Monthly Budget: {$budget}\n\n";
    $body .= "Goals / Message:\n{$message}";

    $headers = ["Content-Type: text/plain; charset=UTF-8", "From: {$name} <{$email}>", "Reply-To: {$email}"];

    $sent = wp_mail( $to, $subject, $body, $headers );
    if ( $sent ) {
        wp_send_json_success( ['message' => "Thanks {$name}! Your message has been sent. I'll reply within 24 hours."] );
    } else {
        wp_send_json_error( ['message' => 'Something went wrong sending your message. Please email directly or use WhatsApp.'] );
    }
}
add_action( 'wp_ajax_dw_contact', 'dw_handle_contact' );
add_action( 'wp_ajax_nopriv_dw_contact', 'dw_handle_contact' );

/* ─── Image sizes ─── */
add_image_size( 'portfolio-thumb', 800, 600, true );
add_image_size( 'blog-thumb', 800, 450, true );
add_image_size( 'team-thumb', 400, 400, true );

/* ─── Disable Gutenberg for certain post types ─── */
function dw_disable_gutenberg( $use, $post_type ) {
    if ( in_array( $post_type, ['testimonial'] ) ) return false;
    return $use;
}
add_filter( 'use_block_editor_for_post_type', 'dw_disable_gutenberg', 10, 2 );

/* ─── Auto create required pages on theme activation ─── */
function dw_create_default_pages() {

    $pages = [
        'home' => [
            'title'    => 'Home',
            'template' => 'front-page.php',
            'slug'     => 'home',
            'parent'   => 0,
        ],
        'services' => [
            'title'    => 'Services',
            'template' => 'page-services.php',
            'slug'     => 'services',
            'parent'   => 0,
        ],
        'services_seo' => [
            'title'    => 'SEO Services',
            'template' => 'page-seo.php',
            'slug'     => 'seo',
            'parent'   => 'services',
        ],
        'services_ppc' => [
            'title'    => 'Paid Ads (PPC)',
            'template' => 'page-ppc.php',
            'slug'     => 'paid-ads',
            'parent'   => 'services',
        ],
        'services_web' => [
            'title'    => 'Web Design & Development',
            'template' => 'page-web-design.php',
            'slug'     => 'web-design',
            'parent'   => 'services',
        ],
        'services_content' => [
            'title'    => 'Content Writing',
            'template' => 'page-content-marketing.php',
            'slug'     => 'content-writing',
            'parent'   => 'services',
        ],
        'portfolio' => [
            'title'    => 'Portfolio',
            'template' => 'page-portfolio.php',
            'slug'     => 'portfolio',
            'parent'   => 0,
        ],
        'about' => [
            'title'    => 'About',
            'template' => 'page-about.php',
            'slug'     => 'about',
            'parent'   => 0,
        ],
        'blog' => [
            'title'    => 'Blog',
            'template' => 'page-blog.php',
            'slug'     => 'blog',
            'parent'   => 0,
        ],
        'contact' => [
            'title'    => 'Contact',
            'template' => 'page-contact.php',
            'slug'     => 'contact',
            'parent'   => 0,
        ],
    ];

    $created_ids = [];

    foreach ( $pages as $key => $data ) {
        // Skip if a page with this slug already exists
        $existing = get_page_by_path( $data['slug'] );
        if ( $existing ) {
            $created_ids[$key] = $existing->ID;
            continue;
        }

        $parent_id = 0;
        if ( ! empty( $data['parent'] ) && isset( $created_ids[ $data['parent'] ] ) ) {
            $parent_id = $created_ids[ $data['parent'] ];
        }

        $page_id = wp_insert_post([
            'post_title'   => $data['title'],
            'post_name'    => $data['slug'],
            'post_status'  => 'publish',
            'post_type'    => 'page',
            'post_parent'  => $parent_id,
            'post_content' => '',
        ]);

        if ( $page_id && ! is_wp_error( $page_id ) ) {
            update_post_meta( $page_id, '_wp_page_template', $data['template'] );
            $created_ids[$key] = $page_id;
        }
    }

    // Set homepage as static front page
    if ( isset( $created_ids['home'] ) ) {
        update_option( 'show_on_front', 'page' );
        update_option( 'page_on_front', $created_ids['home'] );
    }

    // Set Blog page as posts page (optional - blog template handles its own loop)
    flush_rewrite_rules();
}
add_action( 'after_switch_theme', 'dw_create_default_pages' );

/* ─── Reading time helper ─── */
function dw_reading_time( $post_id ) {
    $content = get_post_field( 'post_content', $post_id );
    $word_count = str_word_count( strip_tags( $content ) );
    $minutes = max( 1, ceil( $word_count / 200 ) );
    return $minutes;
}

/* ─── Body class for service sub-pages (adds parent slug) ─── */
function dw_body_classes( $classes ) {
    if ( is_page() ) {
        global $post;
        if ( $post && $post->post_parent ) {
            $parent = get_post( $post->post_parent );
            if ( $parent ) {
                $classes[] = 'parent-' . $parent->post_name;
            }
        }
    }
    return $classes;
}
add_filter( 'body_class', 'dw_body_classes' );
