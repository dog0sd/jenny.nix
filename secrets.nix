let
  # thinkcentre host key (for decryption on the machine)
  jenny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwYylFA+EguFhZs+bq5R6mAMpT/nkw+g8aUXO03nbfz root@nixos";

  # workstation key (for encrypting secrets locally)
  grisha = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrHB7G59MASG6JjFdUyuEMxfmttXAKqRLMudWlrt1h2bcA7aHCU32v/iQzOjzw3w26NLEKTY07CjLJq2/2lkd4QWMxUgMHj4AfcuoZm38Hw5aBsE4cz/A+zleK2sB7i/3iCWcBFoExkt+gE+F99mBqZrt+Ei5BdzD60AU2epcHjcHeEj7g94DL7grQI1NcoD9ygApT0v0lJd0MTB6Yum6AstsrbrSYnLo/lHEv/aHz6kEN7AWEQK+kqpUuaawHsh8grlaCvUfM3zmThangpxbNLDRtLhfrIImL9OE9oYnysZN03x+5rZOjjoSw3eTkcAHYfeQ1+XqkIcEYyd0LN1q/X/nQBHyExfsVsRUkpdPLUqjGdbMjxM4Kv49BcAvbY41SIOiWG75YmvMnoHivvulCmmDJJ3WbAfSE3Q6dliD2VbZZvvXdEV2tc16EGETpJB5rpxNT2l2umkdqFeqBEkb/3D4EjNFsIln+pI+E4mWSB43au9eqWp2tqXAx+hL/yic= dog0sd@pm.me";
in
{
  "secrets/cf-dns-api-token.age".publicKeys = [ jenny grisha ];
  "secrets/telegram-bot-token.age".publicKeys = [ jenny grisha ];
}
