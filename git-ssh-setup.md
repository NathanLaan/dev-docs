# git-ssh-setup

1. Generate the key on local workstation.

  ```bash
  ssh-keygen -t ed25519 -C "email@email.com"
  ```

2. On Windows, sometimes the OpenSSH service will be set to disabled or manual. [Start the service](https://stackoverflow.com/questions/65741816/error-connecting-to-agent-no-such-file-or-directory-adding-key-to-ssh-agent).

3. Add the generated key to the SSH service.

  ```bash
  ssh-add id_ed25519
  ```

4. On Windows, copy the output to the clipboard. Windows PowerShell hasn't implemented > so:

  ```bash
  Get-Content .\id_ed25519.pub | clip
  ```

5. Paste the contents into the [Github SSH page](https://github.com/settings/ssh/new).

# References

- [Connecting to GitHub with SSH: Generating an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Connecting to GitHub with SSH: Adding the SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
