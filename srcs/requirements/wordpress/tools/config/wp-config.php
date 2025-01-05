<?php
/**
 * The base configuration for WordPress
 *
 * This file has the following configurations:
 * - MySQL settings
 * - Secret keys
 * - Database table prefix
 * - ABSPATH
 */

 require_once __DIR__ . '/vendor/autoload.php';  // Inclure l'autoloader de Composer si vous avez utilisé Composer

 $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
 $dotenv->load();
 
 // ** MySQL settings ** //
 define('DB_NAME', 'openWorld');          // Nom de la base de données
 define('DB_USER', 'root');               // Utilisateur de la base de données (modifiez si nécessaire)
 define('DB_PASSWORD', $_ENV['DB_ROOT_PASSWORD']);  // Récupérer le mot de passe depuis .env
 define('DB_HOST', 'localhost');          // Hôte de la base de données
 
 // Les autres configurations comme avant...
 define('DB_CHARSET', 'utf8mb4');
 define('DB_COLLATE', '');
 

// ** Authentication Unique Keys and Salts ** //
// These unique keys and salts should be replaced with randomly generated values.
// You can generate them from https://api.wordpress.org/secret-key/1.1/salt/
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

// ** WordPress Database Table prefix ** //
$table_prefix = 'wp_';  // Change this prefix to enhance security if needed

// ** Site URL and Home URL ** //
define('WP_HOME', 'https://rihoy.42.fr');
define('WP_SITEURL', 'https://rihoy.42.fr');

// ** Debugging mode ** //
// Set this to true to display error notices during development.
define('WP_DEBUG', false);

// ** Absolute path to the WordPress directory ** //
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

// ** Sets up WordPress vars and included files ** //
require_once ABSPATH . 'wp-settings.php';
