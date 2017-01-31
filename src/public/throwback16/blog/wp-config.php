<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'throwbackwordpress');

/** MySQL database username */
define('DB_USER', 'usertbwp');

/** MySQL database password */
define('DB_PASSWORD', 'pwdtbwp');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

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
define('AUTH_KEY',         '1>U$@XcUJcRNN!p3 =WN>V>POMwdm5_5d $Cn_PxqG@5RS@v/7 gddb.E[cN|ZyL');
define('SECURE_AUTH_KEY',  '^ux@[: 0DC&D&}L*COg-Od$UurXh@lEi1m+C9f$s_ {%`!i/c)3(Unz]3F~sH7za');
define('LOGGED_IN_KEY',    'pMmyaKWP}z3&$gN,tSlf%ff#X{KG3/l/AH9[wO|@$|Cl`4M]nt0Ed.tVUnmZAHS@');
define('NONCE_KEY',        '}QL,@qO3k@jHBA(r2)E;#9xQ(/h#nlOOTUK*)oGr#@AI.Gm*_Kvk_R&*J]lE@fv[');
define('AUTH_SALT',        'p:#d-6 -BL4Y%bh7WnVkNegoXqm`>vHaob&x6!kpiOE[OY~IV?^GDXQ_6pm;++&+');
define('SECURE_AUTH_SALT', 'J%d_aE^gS@01izraVg7}>X$_eeg&ep#;{93G7f[>,2m)*0J8V)f~ev>>f8VgCjl&');
define('LOGGED_IN_SALT',   '@%A,68}u+M[SI(40^k#|/~$Cc1z9,FR??=F]2ZJlB>}kMfRb$VDPT}O1o[Kr>$a4');
define('NONCE_SALT',       'PZlw=Q`aILpzuj1SE)~U 7%5$HBXKg5;e:cigquJLL9QQ+^,uu!.4Bi1Pd_ao+];');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
