<?php

foreach($cfg['Servers'] as $key => $server) {
    $cfg['Servers'][$key]['auth_type'] = 'config';
    $cfg['Servers'][$key]['user'] = 'root';
    $cfg['Servers'][$key]['password'] = 'password';
}

ini_set("session.gc_maxlifetime", 100000);
$cfg['LoginCookieValidity'] = 100000;
$cfg['MaxNavigationItems'] = 300;
$cfg['LeftDisplayTableFilterMinimum'] = 300;
