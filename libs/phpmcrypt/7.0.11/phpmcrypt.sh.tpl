#!/bin/bash -l
#@      cw_TEMPLATE[name]="PHPMCrypt v7.0.11 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Basic encryption and decryption of a string"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#==============================================================================
# Copyright (C) 2016 Alces Software Ltd.
#
# This work is licensed under a Creative Commons Attribution-ShareAlike
# 4.0 International License.
#
# See http://creativecommons.org/licenses/by-sa/4.0/ for details.
#==============================================================================

#############################################
# SGE Directives - Change as required
#############################################

#$ -cwd
#$ -V
#$ -j y
#$ -o $HOME/phpmcrypt_out.$JOB_ID
#$ -N phpmcrypt
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full MCrypt usage information see:
#   http://mcrypt.sourceforge.net/

# Loading MCrypt module
module load libs/phpmcrypt

# Creating example of phpmcrypt
cat <<EOF > php-mcrypt-example.php
#!/usr/bin/php
<?php
/*
 * PHP mcrypt - Basic encryption and decryption of a string
 */
\$string = "Some text to be encrypted";
\$secret_key = "This is my secret key123";

// Create the initialization vector for added security.
\$iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB), MCRYPT_RAND);

// Encrypt $string
\$encrypted_string = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, \$secret_key, \$string, MCRYPT_MODE_CBC, \$iv);

// Decrypt $string
\$decrypted_string = mcrypt_decrypt(MCRYPT_RIJNDAEL_256, \$secret_key, \$encrypted_string, MCRYPT_MODE_CBC, \$iv);

echo "Original string : " . \$string . "\n";
echo "Encrypted string : " . \$encrypted_string . "\n";
echo "Decrypted string : " . \$decrypted_string . "\n";
?>
EOF

# Running generated example file
php php-mcrypt-example.php


echo ""
echo "---------------------"
echo " PHPMCrypt completed "
echo "---------------------"
