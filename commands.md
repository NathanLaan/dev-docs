# Commands

- Convert CDR to ISO for mounting on other OS.

  ```bash
  % hdiutil convert /path/to/file.cdr -format UDTO -o /path/to/output.iso
  ```

- Create USB boot drive:

  ```bash
  % hdiutil mount Win11_22H2_English_x64v1.iso
  % diskutil list external
  % cp -rp /Volumes/CCCOMA_X64FRE_EN-US_DV9/* /Volumes/WIN11
  ```
