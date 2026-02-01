let
  # TODO: replace with actual host key from: ssh jenny cat /etc/ssh/ssh_host_ed25519_key.pub
  jenny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwYylFA+EguFhZs+bq5R6mAMpT/nkw+g8aUXO03nbfz root@nixos";

  # Optional: your local workstation key for encrypting secrets
  # user = "ssh-ed25519 AAAA_YOUR_USER_KEY";
in
{
  "secrets/cf-dns-api-token.age".publicKeys = [ jenny ];
  "secrets/telegram-bot-token.age".publicKeys = [ jenny ];
}
