<?php 
session_start();
session_unset();
session_destroy();
header('Location: login.html?loggedout=1');
exit();
?>
