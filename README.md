# Commiterator

Script that does various checks against git commits. 
Main usage is through [pre-commit](http://pre-commit.com), but can be use standalone if needed (via cloning this repo)

## Available hooks

### `check-message`

Validates whether your commit message contains the specified pattern match (passed via args).

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commiterator
    rev: main (or specific tag version)
    hooks:
      - id: check-message
        args: [TASK-[0-9]{4,}]
        stage: [commit-msg]
```

### `prepend-message`

Prepends your commit message with specified message (passed via args).

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commiterator
    rev: main (or specific tag version)
    hooks:
      - id: prepend-message
        args: ['TASK-12345 - ']
        stage: [prepend-commit-msg]
```

### `verify-signature`

Verifies signature on all unpushed commits

**Example Usage**
```yaml
  - repo: https://github.com/punitlad/commiterator
    rev: main (or specific tag version)
    hooks:
      - id: verify-signature
        stage: [push]
```