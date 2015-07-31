#!/usr/bin/php

<?php
$PHPUnit = 'PHPUnit-3.4.15';
$PEAR = '/usr/bin/pear';
$CURL = '/usr/bin/curl';
$PACKAGE = 'http://pear.in2itvof.com/get/PHPUnit-3.4.15.tgz';

if (false === file_exists($PEAR)) {
    echo sprintf('%s is not installed');
    exit(1);
}

echo sprintf('Installing %s', $PHPUnit);
system(sprintf('%s %s | tar xz', $CURL, $PACKAGE));

$pear_dir = system(sprintf('%s config-get php_dir', $PEAR));
$bin_dir = system(sprintf('%s config-get bin_dir', $PEAR));
$path = $pear_dir . DIRECTORY_SEPARATOR . 'PHPUnit';
system(sprintf('mv %s/PHPUnit %s', $PHPUnit , $path));

system(sprintf('cp %s/phpunit.php %s/phpunit', $PHPUnit, $bin_dir));
system(sprintf('cp %s/dbunit.php %s/dbunit', $PHPUnit, $bin_dir));

echo sprintf('Installation of %s complete', $PHPUnit) . PHP_EOL;
echo PHP_EOL;
echo sprintf('Ensure %s is in your include path', $pear_dir) . PHP_EOL;
echo PHP_EOL;
echo 'Usage:' . PHP_EOL;
echo sprintf("\tPHPUnit: %s/phpunit", $bin_dir) . PHP_EOL;
echo sprintf("\tDBUnit: %s/dbunit", $bin_dir) . PHP_EOL;
exit(0);
echo sprintf('Installation of %s complete', $PHPUnit);