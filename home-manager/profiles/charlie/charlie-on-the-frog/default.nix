{ inputs, ... }:
{
  imports = [
    (inputs.self + /home-manager/profiles/charlie)
    (inputs.self + /home-manager/so-you-want-to/be-a-developer)
    (inputs.self + /home-manager/so-you-want-to/be-a-communicator)
  ];
}
