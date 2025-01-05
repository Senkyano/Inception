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
define('AUTH_KEY',         'Si5$vzT~.}Vc+!wG.4-mi&vxWx4-P{P|F8DMK}F21I&_K$WKf`3Vb9US)2]avnh-');
define('SECURE_AUTH_KEY',  'jNq|/O;VXe=)anv]-Ju1cJ|4nW,P=E3-D8}iCb|J&aT:TRq)u4E-jz]?2q)x[T(C');
define('LOGGED_IN_KEY',    '|ikz)W8&Xf0oN<TG+>u84#|]*b|,7TnWr| 5~XfkZx_r[$rJSe3u<76jt!YSo}gO');
define('NONCE_KEY',        '}hC8K-`yjT0j6wO+Mz141<ek.?M6=xT|H]EkFu!sqJ?]Z/l|XG9as09WO#FTxzwq');
define('AUTH_SALT',        'J-}-D>~{J9-XBC]<!-6qx}dv}mVX.Z@#Q>MHqqf0;6&XUuD^3m8/If4 ?&=H2J.l');
define('SECURE_AUTH_SALT', '/08oU&q9t:|xXKu.[vy0og@Z*yP[jc/0$z?;jR`~()|^~<~m71UOl,Y(aYfw$DNx');
define('LOGGED_IN_SALT',   'TrDyr6aGJ 8)^p ^;M<rCFwHp:;t0Vb|39*cVTWvg}&fPVXdXoe NUe|S5_,yJ+v');
define('NONCE_SALT',       'zt:gElEuMv7b|Q0Y=Qi(?E8s_n:s-qa+=;$WGx[<|-`:mL7$Y[kd;[GuM!UmJ#BV');

// ** WordPress Database Table prefix ** //
$table_prefix = 'wp_';  // Change this prefix to enhance security if needed

// ** Site URL and Home URL ** //
define('WP_HOME', 'https://rihoy.42.fr');
define('WP_SITEURL', 'https://rihoy.42.fr');

// ** Debugging mode ** //
// Set this to true to display error notices during development.
define('WP_DEBUG', true);

// ** Absolute path to the WordPress directory ** //
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

// ** Sets up WordPress vars and included files ** //
require_once ABSPATH . 'wp-settings.php';
