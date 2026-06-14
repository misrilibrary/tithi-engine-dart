# Security Policy

`tithi_engine` is a pure-Dart library with **no runtime dependencies** and no
network, file-system, or process access — it performs offline date/astronomical
math over bundled constant data. The practical attack surface is therefore very
small, but we still take reports seriously.

## Supported Versions

Security fixes are applied to the latest published minor on pub.dev.

| Version | Supported          |
| ------- | ------------------ |
| 2.0.x   | :white_check_mark: |
| < 2.0   | :x:                |

If a fix is required, it ships as a new patch release (e.g. `2.0.x`); older lines
are not back-patched — please upgrade to the latest `2.0.x`.

## Reporting a Vulnerability

Please **do not** open a public issue for security problems.

- Use GitHub's private vulnerability reporting:
  **Security → Report a vulnerability** on
  <https://github.com/misrilibrary/tithi-engine-dart/security/advisories/new>.
- Include the affected version, a description, and a minimal reproduction if possible.

**What to expect:**

- Acknowledgement within **5 business days**.
- An initial assessment (accepted / needs-info / declined) within **10 business days**.
- If accepted, a fix is published as a new patch release and the advisory is
  disclosed once users have had a reasonable window to upgrade.
- If declined, you'll get a short explanation (e.g. out of scope, not reproducible,
  or expected behavior).

For non-security bugs, please use the normal
[issue tracker](https://github.com/misrilibrary/tithi-engine-dart/issues).
