{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.stennsen = {
    isNormalUser = true;
    description = "Stennsen";
    initialHashedPassword = "$y$j9T$BJDaYRt/xn.jCXJZRcCJv1$FZhgdj04vgi/ilGWOQ0.xiW6Qop.KLK2nDx47mLoNN6"; # generate passwords with `mkpasswd`
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
}
