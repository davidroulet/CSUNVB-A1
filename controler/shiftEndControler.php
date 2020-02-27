<?php
/**
 * Auteur: Thomas Grossmann / Mounir Fiaux
 * Date: Février 2020
 **/

require_once 'model/shiftEndModel.php';

function shiftEndHomePage()
{
    require_once 'view/viewsShiftEnd/shiftEndHome.php';
}

function disconnect()
{
    unset($_SESSION['username']);
    unset($_SESSION['password']);
    unset($_SESSION['base']);
    require_once 'view/home.php';
}

function login()
{
    require_once 'view/login.php';

}
function trylogin($username, $password, $base)
{
    $DefautPasswordHash = password_hash("usermdp", PASSWORD_DEFAULT);
    if ($username == "user" && password_verify($password, $DefautPasswordHash) && $base == true)
    {
        $_SESSION['username'] = $username;
        $_SESSION['password'] = $password;
        $_SESSION['base'] = $base;
        require_once 'view/home.php';
    } else
    {
        errorLogin();
    }
}

function errorLogin()
{
    require_once 'view/errorLogin.php';
}
?>
