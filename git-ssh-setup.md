# git-ssh-setup

## Git Setup

  ```bash
  git config --global user.name "USERNAME"
  git config --global user.email "NAME@DOMAIN.com"
  ```

## Git SSH Setup

1. On Windows, sometimes the OpenSSH service will be set to disabled or manual. [Start the service](https://stackoverflow.com/questions/65741816/error-connecting-to-agent-no-such-file-or-directory-adding-key-to-ssh-agent). Run the following in PowerShell:

  ```bash
  Get-Service ssh-agent | Set-Service -StartupType Automatic
  Start-Service ssh-agent
  Get-Service ssh-agent
  # This should return a status of Running
  ```

2. Generate the keys on local workstation. Use `id_github` and `id_gitlab` as the convention for naming the keys.

  ```bash
  cd ~\.ssh
  ssh-keygen -t ed25519 -C "NAME@DOMAIN.com" -f id_github
  ssh-keygen -t ed25519 -C "NAME@DOMAIN.com" -f id_gitlab
  ```

3. Add the generated key to the SSH service.

  ```bash
  ssh-add id_github
  ssh-add id_gitlab
  ```
  
  or:

  ```bash
  ssh-add c:\Users\USERNAME\.ssh\id_github
  ssh-add c:\Users\USERNAME\.ssh\id_gitlab
  ```

4. Copy the output to the clipboard. Windows PowerShell hasn't implemented the > operator, so run the following instead:

  Windows:

  ```bash
  Get-Content .\id_github.pub | clip
  Get-Content .\id_gitlab.pub | clip
  ```

  Linux:
  
  ```bash
  cat ~/.ssh/id_github.pub
  cat ~/.ssh/id_gitlab.pub
  ```

5. Paste the contents into the [Add new SSH keys page](https://github.com/settings/ssh/new) on GitHub or the [SSH Keys](https://gitlab.com/-/profile/keys) page on GitLab.

6. For GitLab, configure SSH to point at the correct SSH key that you generated by editing or creating the `~/.ssh/config` config file:

  ```bash
  # GitHub
  Host github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_github

  # GitLab PERSONAL_ACCOUNT
  Host gitlab.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_gitlab
  
  # GitLab WORKACCOUNT
  Host gitlab.com-WORKACCOUNTNAME
  HostName gitlab.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_gitlab_WORKACCOUNT
  ```

7. Disable firewall Threat Management for GitLab and GitHub:

  - Go to [Network Security](https://192.168.1.1/network/default/settings/security)
  - Go to *Threat Management Allow List* or *Security Detection Allow List*.
  - Add New.
  - Add GitLab IPs (172.65.251.78 and 172.65.251.182).
  - Set *Direction* to `both`.
  - Save.
  - Add New.
  - Add GitHub IP (140.82.114.4).
  - Set *Direction* to `both`.
  - Save.

8. **Optional** Setup GitLab to use port 443. Modify the `C:\Users\USERNAME\.ssh\config` file to include:

  ```bash
  Hostname altssh.gitlab.com
  User git
  Port 443
  ```

9. Run:

  ```bash
  ssh -T git@gitlab.com
  ```

# References

- [Connecting to GitHub with SSH: Generating an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Connecting to GitHub with SSH: Adding the SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
