# Update Protocol

Use this protocol whenever the user asks to persist a new tool, service, workflow, exception, or preference in this skill.

## Adding a Tool or Service

1. Decide whether it is a standalone tool, a language/runtime environment, or a service workflow.
2. Add it to `environment-workflows.md` under the right workflow, or create a new workflow section if needed.
3. Record dependencies instead of duplicating full install instructions.
4. Do not pin versions unless the user asks or compatibility requires it.
5. Add personal defaults, exceptions, or special handling to `preferences.md`.
6. Before changing the actual environment, include the new item in the consolidated checklist and ask for one plan-level confirmation.

## Updating an Existing Workflow

1. Preserve user data and service state by default.
2. Prefer verification and repair over reinstall.
3. Only remove, recreate, downgrade, or replace components after explicit user confirmation.
4. Record newly discovered compatibility issues or personal decisions in `preferences.md`.
5. Keep confirmation behavior plan-level: ask once for the selected checklist, then ask again only for destructive or high-risk actions.

## Removing a Tool or Service

1. Remove it from the required workflow only when the user explicitly says it should no longer be restored.
2. If the user is unsure, mark it as not required or pending instead of deleting the history outright.
3. Do not uninstall or delete runtime data unless the user explicitly confirms that action.

## Git Hygiene

1. Review diffs before committing.
2. Check for secrets, tokens, private keys, logs, histories, and generated state.
3. Commit reference updates separately from environment-changing scripts if scripts are introduced later.
