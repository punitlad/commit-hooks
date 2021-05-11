# Commit Hooks

Git hooks that are able to integrate with [pre-commit](http://pre-commit.com).

## Available hooks

### `check-commit-message`

Validates whether your commit message contains the specified pattern match (passed via args).

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commit-hooks
    rev: v1.3.0
    hooks:
      - id: check-commit-message
        args: [TASK-[0-9]{4,}]
        stage: [commit-msg]
```

### `prepend-commit-message`

Prepends your commit message with specified message (passed via args).

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commit-hooks
    rev: v1.3.0
    hooks:
      - id: prepend-commit-message
        args: ['TASK-12345 - ']
        stage: [prepend-commit-msg]
```

### `verify-commit-signature`

Verifies signature on all unpushed commits

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commit-hooks
    rev: v1.3.0
    hooks:
      - id: verify-commit-signature
        stage: [push]
```