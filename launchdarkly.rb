cheatsheet do
  title 'LaunchDarkly Custom Roles Cheatsheet'               # Will be displayed by Dash in the docset list
  docset_file_name 'LaunchDarklyRBAC'    # Used for the filename of the docset
  keyword 'launchdarkly-rbac'             # Used as the initial search keyword (listed in Preferences > Docsets)
  # resources 'resources_dir'  # An optional resources folder which can contain images or anything else
  
  introduction <<-'END'
  Custom roles give you fine-grained access control to everything in LaunchDarkly, from feature flags to metrics, environments, and teams. With custom roles, it''s possible to enforce access policies that meet your exact workflow needs.
  END


  category do
    id 'Policies'
    entry do
      notes <<-'END'
      Policies are represented as JSON arrays of objects containing 3 elements.
      END
    end

    entry do
      command 'effect'
      notes <<-'END'
      Either `allow` or `deny`
      This attribute defines whether the statement allows or denies access to the named resources and actions.
      END
    end
    entry do
      command 'resource'
      command 'notResource'
      notes <<-'END'
      A list of resource specifiers defining the resources to which the statement applies or does not apply.
      END
    end
    entry do
      command 'action'
      command 'notAction'
      notes <<-'END'
      A list of action specifiers defining the actions to which the statement applies or does not apply.
      Supports glob matching (`update*`, `delete*`, etc)
      END
    end
    entry do 
      name 'Algorithm'
      notes <<-'END'
      The algorithm for determining whether access is allowed or denied by a policy is as follows:

      - If any statement in the policy explicitly denies access to a resource and action, access is denied
      - If a statement in the policy explicitly allows access to a resource and action, and no statement denies access, access is allowed
      
      This means that statement order does not matter.
      
      Note that users can be members of multiple custom roles, and each custom role has its own policy. If any custom role allows access, then access is allowed. This means that adding roles to a user can only increase that user''s access.
      END
    end
    entry do 
      name 'Example: Deny access to flags in production environment'
      notes <<-'END'
      ```javascript
      {
        "effect": "deny",
        "resources": [
          "proj/*:env/production:flag/*"
        ],
        "actions": [
          "*"
        ]
      }
      ```
      END
    end
    entry do 
      name 'Example: Blacklist project'
      notes <<-'END'
      ```javascript
      [
        {
          "resources": ["proj/project"],
          "actions": ["viewProject"],
          "effect": "deny"
        }
      ]
      ```
      END
    end
    entry do 
      name 'Example: Whitelist project'
      notes <<-'END'
      ```javascript
      [
        {
          "notResources": ["proj/project"],
          "actions": ["viewProject"],
          "effect": "allow"
        }
      ]
      ```
      END
    end
  end

  category do
    id 'Resource Specifiers'
    entry do 
      name 'Resource Specifier'
      command 'resource-type/key;tag1,tag2'
    end
    entry do 
      name 'Scoped Resource'
      command 'parent-resource/key;tag1,tag2:child-resource/key;tag3,tag4'
    end
    entry do 
      name 'All Projects'
      command 'proj/*'
    end
    entry do 
      name 'Projects starting with `prefix`'
      command 'proj/prefix*'
    end
    entry do 
      name 'Projects tagged `example`'
      command 'proj/*;example'
    end

      entry do 
        name 'All feature flags'
        command 'proj/*:env/*:flag/*'
      end
      entry do 
        name 'Feature flags in projects tagged `team`'
        command 'proj/*;team:env/*:flag/*'
      end
      entry do 
        name 'Feature flags in production environments'
        command 'proj/*:env/production:flag/*'
      end
  end

  category do 
    id 'Projects'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'proj'   # Multiple commands are supported
      command 'proj/*'
      index_name 'Resource'
      extra_index_name 'Proj'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>proj</code> is a <strong>top-level resource</strong>. 
To learn more, read <a href="https://docs.launchdarkly.com/docs/projects" ui-sref="docs.show({'doc': 'projects'})" class="doc-link" data-sidebar="projects">Projects</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createProject'   # Multiple commands are supported
      notes <<-'END'
        Create a new project

      END
    end 


    entry do
      command 'deleteProject'   # Multiple commands are supported
      notes <<-'END'
        Delete a project

      END
    end 


    entry do
      command 'updateProjectName'   # Multiple commands are supported
      notes <<-'END'
        Rename a project

      END
    end 


    entry do
      command 'updateIncludeInSnippetByDefault'   # Multiple commands are supported
      notes <<-'END'
        Make new flags available to the client-side (JavaScript) SDK by default

      END
    end 


    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with a project

      END
    end 


    entry do
      command 'viewProject'   # Multiple commands are supported
      notes <<-'END'
        View a project. If set to deny, anyone impacted by this policy can neither view nor modify a project.
To learn more, read Configuring private projects with custom roles.

      END
    end 

  end 


  category do 
    id 'Environments'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'env'   # Multiple commands are supported
      command 'proj/*:env/*'
      index_name 'Resource'
      extra_index_name 'Env'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>env</code> is a child resource of <strong>projects</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/environments" ui-sref="docs.show({'doc': 'environments'})" class="doc-link" data-sidebar="environments">Environments</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createEnvironment'   # Multiple commands are supported
      notes <<-'END'
        Create new environments

      END
    end 


    entry do
      command 'deleteEnvironment'   # Multiple commands are supported
      notes <<-'END'
        Delete an existing environment

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of an environment

      END
    end 


    entry do
      command 'updateColor'   # Multiple commands are supported
      notes <<-'END'
        Change the color swatch for an environment

      END
    end 


    entry do
      command 'updateTtl'   # Multiple commands are supported
      notes <<-'END'
        Change the TTL for an environment

      END
    end 


    entry do
      command 'updateApiKey'   # Multiple commands are supported
      notes <<-'END'
        Reset the API key for an environment

      END
    end 


    entry do
      command 'updateMobileKey'   # Multiple commands are supported
      notes <<-'END'
        Reset the mobile key for an environment

      END
    end 


    entry do
      command 'updateSecureMode'   # Multiple commands are supported
      notes <<-'END'
        Turn secure mode on or off for an environment

      END
    end 


    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with an environment

      END
    end 


    entry do
      command 'updateRequireComments'   # Multiple commands are supported
      notes <<-'END'
        Require comments for changes to flags and segments

      END
    end 


    entry do
      command 'updateConfirmChanges'   # Multiple commands are supported
      notes <<-'END'
        Require environment confirmation for changes to flags and segments

      END
    end 

  end 


  category do 
    id 'Metrics'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'metric'   # Multiple commands are supported
      command 'proj/*:metric/*'
      index_name 'Resource'
      extra_index_name 'Metric'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>metric</code> is a child resource of <strong>projects</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/experimentation" ui-sref="docs.show({'doc': 'experimentation'})" class="doc-link" data-sidebar="experimentation">Experimentation introduction</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createMetric'   # Multiple commands are supported
      notes <<-'END'
        Create metrics

      END
    end 


    entry do
      command 'deleteMetric'   # Multiple commands are supported
      notes <<-'END'
        Delete metrics

      END
    end 


    entry do
      command 'updateKey'   # Multiple commands are supported
      notes <<-'END'
        Update keys for custom metrics

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Update metrics names

      END
    end 


    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Update metrics descriptions

      END
    end 


    entry do
      command 'updateUrls'   # Multiple commands are supported
      notes <<-'END'
        Update the URLs for a click or page view metric

      END
    end 


    entry do
      command 'updateSelector'   # Multiple commands are supported
      notes <<-'END'
        Update the CSS selector for a click metric

      END
    end 


    entry do
      command 'updateOptimizelyMetrics'   # Multiple commands are supported
      notes <<-'END'
        Update Optimizely metrics

      END
    end 

  end 


  category do 
    id 'Flags'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'flag'   # Multiple commands are supported
      command 'proj/*:env/*:flag/*'
      index_name 'Resource'
      extra_index_name 'Flag'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>flag</code> is a child of <strong>both a project and environments</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/creating-a-feature-flag" ui-sref="docs.show({'doc': 'creating-a-feature-flag'})" class="doc-link" data-sidebar="creating-a-feature-flag">Creating a feature flag</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createFlag'   # Multiple commands are supported
      notes <<-'END'
        Create a feature flag. Creating a feature flag impacts all environments in a project, so users will need permission to create flags in all environments.

      END
    end 


    entry do
      command 'cloneFlag'   # Multiple commands are supported
      notes <<-'END'
        Create a new flag with settings based on an existing flag. To clone a flag, you need to have the cloneFlag permission on the source flag, as well as the createFlag permission for the new flag

      END
    end 


    entry do
      command 'deleteFlag'   # Multiple commands are supported
      notes <<-'END'
        Delete a feature. Deleting a feature impacts all environments in a project, so users will need permission to delete features in all environments.

      END
    end 


    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Trigger the kill switch for a feature

      END
    end 


    entry do
      command 'updateIncludeInSnippet'   # Multiple commands are supported
      notes <<-'END'
        Change whether the feature flag is available to front-end code via the JavaScript SDK . Impacts all environments in a project.

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a feature flag. Impacts all environments in a project.

      END
    end 


    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Change the description of a feature flag. Impacts all environments in a project.

      END
    end 


    entry do
      command 'updateTemporary'   # Multiple commands are supported
      notes <<-'END'
        Marks a flag temporary or permanent. Impacts all environments in a project.

      END
    end 


    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with a flag. Impacts all environments in a project.

      END
    end 


    entry do
      command 'updatePrerequisites'   # Multiple commands are supported
      notes <<-'END'
        Update flag prerequisites.

      END
    end 


    entry do
      command 'updateTargets'   # Multiple commands are supported
      notes <<-'END'
        Update individual user targeting.

      END
    end 


    entry do
      command 'updateRules'   # Multiple commands are supported
      notes <<-'END'
        Update custom targeting rules.

      END
    end 


    entry do
      command 'updateFallthrough'   # Multiple commands are supported
      notes <<-'END'
        Update the "default" or "fallthrough" rule.

      END
    end 


    entry do
      command 'updateFlagVariations'   # Multiple commands are supported
      notes <<-'END'
        Change the flag''s variations. Impacts all environments.

      END
    end 


    entry do
      command 'updateOffVariation'   # Multiple commands are supported
      notes <<-'END'
        Update the variation returned when the kill switch is set to off.

      END
    end 


    entry do
      command 'updateMaintainer'   # Multiple commands are supported
      notes <<-'END'
        Update the flag maintainer. Impacts all environments.

      END
    end 


    entry do
      command 'updateAttachedMetrics'   # Multiple commands are supported
      notes <<-'END'
        Update metrics connected to a flag (start or pause an experiment).

      END
    end 


    entry do
      command 'updateFlagCustomProperties'   # Multiple commands are supported
      notes <<-'END'
        Update custom properties attached to a flag. Impacts all environments.

      END
    end 


    entry do
      command 'updateVariations'   # Multiple commands are supported
      notes <<-'END'
        Update percentage rollout variations

      END
    end 

  end 


  category do 
    id 'Segments'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'segment'   # Multiple commands are supported
      command 'proj/*:env/*:segment/*'
      index_name 'Resource'
      extra_index_name 'Segment'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>segment</code> is a child of <strong>both a project and environments</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/segmenting-users" ui-sref="docs.show({'doc': 'segmenting-users'})" class="doc-link" data-sidebar="segmenting-users">Building user segments</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createSegment'   # Multiple commands are supported
      notes <<-'END'
        Create a segment.

      END
    end 


    entry do
      command 'deleteSegment'   # Multiple commands are supported
      notes <<-'END'
        Delete a segment

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Update segment name.

      END
    end 


    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Update segment description.

      END
    end 


    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with a segment.

      END
    end 


    entry do
      command 'updateIncluded'   # Multiple commands are supported
      notes <<-'END'
        Update the list of users explicitly included in a segment.

      END
    end 


    entry do
      command 'updateExcluded'   # Multiple commands are supported
      notes <<-'END'
        Update the list of users explicitly excluded from a segment.

      END
    end 


    entry do
      command 'updateRules'   # Multiple commands are supported
      notes <<-'END'
        Update the targeting rules for a segment.

      END
    end 

  end 

  category do 
    id 'Users'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'user'   # Multiple commands are supported
      command 'proj/*:env/*:user/*'
      index_name 'Resource'
      extra_index_name 'User'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>user</code> is a child of <strong>both a project and environments</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/the-user-dashboard" ui-sref="docs.show({'doc': 'the-user-dashboard'})" class="doc-link" data-sidebar="the-user-dashboard">The user dashboard</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'deleteUser'   # Multiple commands are supported
      notes <<-'END'
        Deletes a user

      END
    end 

  end 
  category do 
    id 'Data Export Destinations'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'destination'   # Multiple commands are supported
      command 'proj/*:env/*:destination/*'
      index_name 'Resource'
      extra_index_name 'Destination'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>destination</code> is a child of <strong>both a project and environments</strong>.
To learn more, read <a href="https://docs.launchdarkly.com/docs/data-export" ui-sref="docs.show({'doc': 'data-export'})" class="doc-link" data-sidebar="data-export">Data Export</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createDestination'   # Multiple commands are supported
      notes <<-'END'
        Create a new destination.

      END
    end 


    entry do
      command 'deleteDestination'   # Multiple commands are supported
      notes <<-'END'
        Delete a destination.

      END
    end 


    entry do
      command 'updateConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Change the settings of a destination.

      END
    end 


    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Turn a destination on or off.

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a destination.

      END
    end 

  end 
  category do
    id 'Account'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'acct'   # Multiple commands are supported
      index_name 'Resource'
      extra_index_name 'Account'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>acct</code> is a unique resource specifier representing modifications to your account itself, such as managing your plan.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end
    entry do
      command 'updateOrganization'   # Multiple commands are supported
      notes <<-'END'
        Update the organization name

      END
    end 


    entry do
      command 'updateSubscription'   # Multiple commands are supported
      notes <<-'END'
        Change the pricing plan (e.g. Startup / Team / Growth) for the account

      END
    end 


    entry do
      command 'updatePaymentCard'   # Multiple commands are supported
      notes <<-'END'
        Change the credit card for the account

      END
    end 


    entry do
      command 'updateRequireMfa'   # Multiple commands are supported
      notes <<-'END'
        Change whether multi-factor authentication (MFA) is required for all users on the account

      END
    end 


    entry do
      command 'updateAccountToken'   # Multiple commands are supported
      notes <<-'END'
        Modify account tokens (for the LaunchDarkly REST API)

      END
    end 


    entry do
      command 'updateSessionRefresh'   # Multiple commands are supported
      notes <<-'END'
        Change whether sessions are refreshed automatically

      END
    end 


    entry do
      command 'updateSessionDuration'   # Multiple commands are supported
      notes <<-'END'
        Change the time a user session will remain active before the user has to re-authenticate

      END
    end 


    entry do
      command 'revokeSessions'   # Multiple commands are supported
      notes <<-'END'
        Revoke all user sessions (logs out all users)

      END
    end 


  end
  category do 
    id 'Members'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'member'   # Multiple commands are supported
      command 'member/*'
      index_name 'Resource'
      extra_index_name 'Member'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>member</code> is a top-level <strong>resource</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/teams" ui-sref="docs.show({'doc': 'teams'})" class="doc-link" data-sidebar="teams">Managing teams</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createMember'   # Multiple commands are supported
      notes <<-'END'
        Add a new team member to an account

      END
    end 


    entry do
      command 'updateRole'   # Multiple commands are supported
      notes <<-'END'
        Update a team member''s built-in roles (reader, writer, or admin)

      END
    end 


    entry do
      command 'updateCustomRole'   # Multiple commands are supported
      notes <<-'END'
        Update a team member''s custom roles

      END
    end 


    entry do
      command 'deleteMember'   # Multiple commands are supported
      notes <<-'END'
        Remove a team member from an account

      END
    end 


    entry do
      command 'sendMfaRequest'   # Multiple commands are supported
      notes <<-'END'
        Send a team member a request to enable MFA

      END
    end 


    entry do
      command 'sendMfaRecoveryCode'   # Multiple commands are supported
      notes <<-'END'
        Send a team member their MFA recovery code

      END
    end 

  end 


  category do 
    id 'Personal Access Tokens'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'token'   # Multiple commands are supported
      command 'member/*:token/*'
      index_name 'Resource'
      extra_index_name 'Token'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>token</code> is a child resource of <strong>members</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/api-access-tokens" ui-sref="docs.show({'doc': 'api-access-tokens'})" class="doc-link" data-sidebar="api-access-tokens">Personal API access tokens</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Create a personal access token

      END
    end 


    entry do
      command 'updateAccessTokenPolicy'   # Multiple commands are supported
      notes <<-'END'
        Change the policy filter of a personal access token

      END
    end 


    entry do
      command 'updateAccessTokenName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a personal access token

      END
    end 


    entry do
      command 'updateAccessTokenDescription'   # Multiple commands are supported
      notes <<-'END'
        Change the description of a personal access token

      END
    end 


    entry do
      command 'deleteAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Delete a personal access token

      END
    end 

  end 


  category do 
    id 'Roles'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'role'   # Multiple commands are supported
      command 'role/*'
      index_name 'Resource'
      extra_index_name 'Role'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>role</code> is a <strong>top-level resource</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/custom-roles" ui-sref="docs.show({'doc': 'custom-roles'})" class="doc-link" data-sidebar="custom-roles">Custom roles</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createRole'   # Multiple commands are supported
      notes <<-'END'
        Create new custom roles

      END
    end 


    entry do
      command 'updatePolicy'   # Multiple commands are supported
      notes <<-'END'
        Update a custom role''s policy

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Update a custom role''s name

      END
    end 


    entry do
      command 'deleteRole'   # Multiple commands are supported
      notes <<-'END'
        Delete a custom role

      END
    end 


    entry do
      command 'updateMembers'   # Multiple commands are supported
      notes <<-'END'
        Add or remove users from a custom role (equivalent to updateCustomRole on team members).

      END
    end 

  end 
  
  category do 
    id 'Webhooks'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'webhook'   # Multiple commands are supported
      command 'webhook/*'
      index_name 'Resource'
      extra_index_name 'Webhook'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>webhook</code> is a <strong>top-level resource</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/webhooks" ui-sref="docs.show({'doc': 'webhooks'})" class="doc-link" data-sidebar="webhooks">Webhooks</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createWebhook'   # Multiple commands are supported
      notes <<-'END'
        Create a new webhook.

      END
    end 


    entry do
      command 'deleteWebhook'   # Multiple commands are supported
      notes <<-'END'
        Delete a webhook.

      END
    end 


    entry do
      command 'updateUrl'   # Multiple commands are supported
      notes <<-'END'
        Update the URL for a webhook.

      END
    end 


    entry do
      command 'updateSecret'   # Multiple commands are supported
      notes <<-'END'
        Update the webhook secret.

      END
    end 


    entry do
      command 'updateStatements'   # Multiple commands are supported
      notes <<-'END'
        Update the policy filter for a webhook.

      END
    end 


    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Turn a webhook on or off.

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a webhook

      END
    end 

  end 


  category do 
    id 'Integrations'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'integration'   # Multiple commands are supported
      command 'integration/*'
      index_name 'Resource'
      extra_index_name 'Integration'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        Most third-party integrations (e.g. <a href="https://docs.launchdarkly.com/docs/hipchat" ui-sref="docs.show({'doc': 'hipchat'})" class="doc-link" data-sidebar="hipchat">HipChat room notifications</a>) use a shared set of custom role actions.
<code>integration</code> is a <strong>top-level resource</strong>.<br />

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createIntegration'   # Multiple commands are supported
      notes <<-'END'
        Create a new third-party integration.

      END
    end 


    entry do
      command 'deleteIntegration'   # Multiple commands are supported
      notes <<-'END'
        Delete a third-party integration.

      END
    end 


    entry do
      command 'updateConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Change the settings of a third-party integration.

      END
    end 


    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Turn a third-party integration on or off.

      END
    end 


    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a third-party integration.

      END
    end 

  end 

  category do 
    id 'Code Reference Repositories'
    entry do 
      notes '<div class="name">Resource</div>'
    end
    entry do
      command 'code-reference-repository'   # Multiple commands are supported
      command 'code-reference-repository/*'
      index_name 'Resource'
      extra_index_name 'Code-reference-repository'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>code-reference-repository</code> is a <strong>top-level resource</strong>.<br />
To learn more, read <a href="https://docs.launchdarkly.com/docs/git-code-references" ui-sref="docs.show({'doc': 'git-code-references'})" class="doc-link" data-sidebar="git-code-references">Git code references</a>.

      END
    end
    entry do 
      notes '<div class="name">Actions</div>'
      index_name "Actions"
    end

    entry do
      command 'createCodeRefsRepository'   # Multiple commands are supported
      notes <<-'END'
        Connect a Git repository.

      END
    end 


    entry do
      command 'updateCodeRefsRepositoryName'   # Multiple commands are supported
      notes <<-'END'
        Update a Git repository connection name.

      END
    end 


    entry do
      command 'updateCodeRefsRepositoryConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Update a Git repository connection configuration.

      END
    end 


    entry do
      command 'updateCodeRefsRepositoryOn'   # Multiple commands are supported
      notes <<-'END'
        Flip the on/off status of a Git repository connection.

      END
    end 


    entry do
      command 'updateCodeRefsRepositoryBranches'   # Multiple commands are supported
      notes <<-'END'
        Update the stored branch data for a Git repository connection.

      END
    end 


    entry do
      command 'deleteCodeRefsRepository'   # Multiple commands are supported
      notes <<-'END'
        Delete a Git repository connection.

      END
    end 

  end 

end