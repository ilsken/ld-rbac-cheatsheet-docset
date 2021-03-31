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
      [{
        "effect": "deny",
        "resources": [
          "proj/*:env/production:flag/*"
        ],
        "actions": [
          "*"
        ]
      }]
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
          "effect": "deny"
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
    id 'Account'
    entry do
      notes 'Resource'
    end
    entry do
      command 'acct'   # Multiple commands are supported
      command 'acct'
      index_name 'Resource'
      extra_index_name 'Account'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        undefined
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'updateOrganization'   # Multiple commands are supported
      notes <<-'END'
        Update the organization name.

      END
    end


          
    entry do
      command 'updateSubscription'   # Multiple commands are supported
      notes <<-'END'
        Change the pricing plan for the account.

      END
    end


          
    entry do
      command 'updateBillingContact'   # Multiple commands are supported
      notes <<-'END'
        Update the billing contact for the account.

      END
    end


          
    entry do
      command 'deleteSubscription'   # Multiple commands are supported
      notes <<-'END'
        Cancel the account plan.

      END
    end


          
    entry do
      command 'updatePaymentCard'   # Multiple commands are supported
      notes <<-'END'
        Change the credit card for the account.

      END
    end


          
    entry do
      command 'updateRequireMfa'   # Multiple commands are supported
      notes <<-'END'
        Change whether multi-factor authentication (MFA) is required for all users on the account.

      END
    end


          
    entry do
      command 'updateAccountToken'   # Multiple commands are supported
      notes <<-'END'
        Reset account tokens (for the{' '}
        <a href="https://apidocs.launchdarkly.com/reference#authentication">LaunchDarkly REST API</a>).

      END
    end


          
    entry do
      command 'deleteAccountToken'   # Multiple commands are supported
      notes <<-'END'
        Delete account tokens (for the{' '}
        <a href="https://apidocs.launchdarkly.com/reference#authentication">LaunchDarkly REST API</a>).

      END
    end


          
    entry do
      command 'createSamlConfig'   # Multiple commands are supported
      notes <<-'END'
        Create a new SAML configuration for the account.

      END
    end


          
    entry do
      command 'deleteSamlConfig'   # Multiple commands are supported
      notes <<-'END'
        Delete the SAML configuration for the account.

      END
    end


          
    entry do
      command 'updateSamlEnabled'   # Multiple commands are supported
      notes <<-'END'
        Enable or disable SAML SSO for the account.

      END
    end


          
    entry do
      command 'updateSamlX509Certificate'   # Multiple commands are supported
      notes <<-'END'
        Update the SAML X509 certificate for the account.

      END
    end


          
    entry do
      command 'updateSamlSsoUrl'   # Multiple commands are supported
      notes <<-'END'
        Update the SAML SSO URL for the account.

      END
    end


          
    entry do
      command 'updateSamlRequireSso'   # Multiple commands are supported
      notes <<-'END'
        Change whether SSO must be used for authentication.

      END
    end


          
    entry do
      command 'createScimConfig'   # Multiple commands are supported
      notes <<-'END'
        Create a new SCIM configuration for the account.

      END
    end


          
    entry do
      command 'deleteScimConfig'   # Multiple commands are supported
      notes <<-'END'
        Delete the SCIM configuration for the account.

      END
    end


          
    entry do
      command 'updateSessionDuration'   # Multiple commands are supported
      notes <<-'END'
        Change the duration of sessions.

      END
    end


          
    entry do
      command 'updateSessionRefresh'   # Multiple commands are supported
      notes <<-'END'
        Change whether sessions are refreshed automatically.

      END
    end


          
    entry do
      command 'revokeSessions'   # Multiple commands are supported
      notes <<-'END'
        Revoke sessions issued before a specified date.

      END
    end

  end

  category do
    id 'Members'
    entry do
      notes 'Resource'
    end
    entry do
      command 'member'   # Multiple commands are supported
      command 'member/*'
      index_name 'Resource'
      extra_index_name 'Members'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>member</code> is a top-level action.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createMember'   # Multiple commands are supported
      notes <<-'END'
        Add a new team member to an account.

      END
    end


          
    entry do
      command 'updateRole'   # Multiple commands are supported
      notes <<-'END'
        Update a team member's built-in roles (reader, writer, or admin).

      END
    end


          
    entry do
      command 'updateCustomRole'   # Multiple commands are supported
      notes <<-'END'
        Update a team member's custom roles.

      END
    end


          
    entry do
      command 'deleteMember'   # Multiple commands are supported
      notes <<-'END'
        Remove a team member from an account.

      END
    end


          
    entry do
      command 'sendMfaRequest'   # Multiple commands are supported
      notes <<-'END'
        Send a team member a request to enable MFA.

      END
    end


          
    entry do
      command 'sendMfaRecoveryCode'   # Multiple commands are supported
      notes <<-'END'
        Send a team member their MFA recovery code.

      END
    end

  end

  category do
    id 'Personal access token'
    entry do
      notes 'Resource'
    end
    entry do
      command 'token'   # Multiple commands are supported
      command 'member/*:token/*'
      index_name 'Resource'
      extra_index_name 'Personal access token'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>token</code> is a child resources of <strong>members</strong>.
      END
    end
    entry do
      notes 'Actions'
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


          
    entry do
      command 'resetAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Reset a personal access token's secret key

      END
    end

  end

  category do
    id 'Service access token'
    entry do
      notes 'Resource'
    end
    entry do
      command 'service-token'   # Multiple commands are supported
      command 'service-token/*'
      index_name 'Resource'
      extra_index_name 'Service access token'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>service-token</code> is a <strong>top-level resource</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Create a service access token.

      END
    end


          
    entry do
      command 'updateAccessTokenName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of a service access token.

      END
    end


          
    entry do
      command 'updateAccessTokenDescription'   # Multiple commands are supported
      notes <<-'END'
        Change the description of a service access token.

      END
    end


          
    entry do
      command 'deleteAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Delete a service access token.

      END
    end


          
    entry do
      command 'resetAccessToken'   # Multiple commands are supported
      notes <<-'END'
        Reset a service access token's secret key.

      END
    end

  end

  category do
    id 'Role'
    entry do
      notes 'Resource'
    end
    entry do
      command 'role'   # Multiple commands are supported
      command 'role/*'
      index_name 'Resource'
      extra_index_name 'Role'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>role</code> is a <strong>top-level resource</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createRole'   # Multiple commands are supported
      notes <<-'END'
        Create new custom roles.

      END
    end


          
    entry do
      command 'updatePolicy'   # Multiple commands are supported
      notes <<-'END'
        Update a custom role's policy.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Update a custom role's name.

      END
    end


          
    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Update a custom role's description.

      END
    end


          
    entry do
      command 'deleteRole'   # Multiple commands are supported
      notes <<-'END'
        Delete a custom role.

      END
    end


          
    entry do
      command 'updateMembers'   # Multiple commands are supported
      notes <<-'END'
        Add or remove users from a custom role (equivalent to <code>updateCustomRole</code> on team members).

      END
    end

  end

  category do
    id 'Project'
    entry do
      notes 'Resource'
    end
    entry do
      command 'proj'   # Multiple commands are supported
      command 'proj/*'
      index_name 'Resource'
      extra_index_name 'Project'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>proj</code> is a <strong>top-level resource</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createProject'   # Multiple commands are supported
      notes <<-'END'
        Create a new project.

      END
    end


          
    entry do
      command 'deleteProject'   # Multiple commands are supported
      notes <<-'END'
        Delete a project.

      END
    end


          
    entry do
      command 'updateProjectName'   # Multiple commands are supported
      notes <<-'END'
        Rename a project.

      END
    end


          
    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with a project.

      END
    end


          
    entry do
      command 'updateIncludeInSnippetByDefault'   # Multiple commands are supported
      notes <<-'END'
        Make new flags available to the client-side (JavaScript) SDK by default.

      END
    end


          
    entry do
      command 'updateDefaultClientSideAvailability'   # Multiple commands are supported
      notes <<-'END'
        Change whether new feature flags are made available to client-side SDKs.

      END
    end


          
    entry do
      command 'viewProject'   # Multiple commands are supported
      notes <<-'END'
        View a project. If set to <code>deny</code>, anyone impacted by this policy can neither view nor modify a
        project.

      END
    end

  end

  category do
    id 'Environments'
    entry do
      notes 'Resource'
    end
    entry do
      command 'env'   # Multiple commands are supported
      command 'proj/*:env/*'
      index_name 'Resource'
      extra_index_name 'Environments'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>env</code> is a child resource of <strong>projects</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createEnvironment'   # Multiple commands are supported
      notes <<-'END'
        Create new environments.

      END
    end


          
    entry do
      command 'deleteEnvironment'   # Multiple commands are supported
      notes <<-'END'
        Delete an existing environment.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of an environment.

      END
    end


          
    entry do
      command 'updateColor'   # Multiple commands are supported
      notes <<-'END'
        Change the color swatch for an environment.

      END
    end


          
    entry do
      command 'updateTtl'   # Multiple commands are supported
      notes <<-'END'
        Change the TTL for an environment.

      END
    end


          
    entry do
      command 'updateApiKey'   # Multiple commands are supported
      notes <<-'END'
        Reset the API key for an environment.

      END
    end


          
    entry do
      command 'updateMobileKey'   # Multiple commands are supported
      notes <<-'END'
        Reset the mobile key for an environment.

      END
    end


          
    entry do
      command 'updateSecureMode'   # Multiple commands are supported
      notes <<-'END'
        Turn secure mode on or off for an environment.

      END
    end


          
    entry do
      command 'updateDefaultTrackEvents'   # Multiple commands are supported
      notes <<-'END'
        Turn on sending detailed information for new flags by default.

      END
    end


          
    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Update tags associated with an environment.

      END
    end


          
    entry do
      command 'updateRequireComments'   # Multiple commands are supported
      notes <<-'END'
        Require comments for changes to flags and segments.

      END
    end


          
    entry do
      command 'updateConfirmChanges'   # Multiple commands are supported
      notes <<-'END'
        Require environment confirmation for changes to flags and segments.

      END
    end

  end

  category do
    id 'Metrics'
    entry do
      notes 'Resource'
    end
    entry do
      command 'metric'   # Multiple commands are supported
      command 'proj/*:metric/*'
      index_name 'Resource'
      extra_index_name 'Metrics'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        Goals have been redesigned as metrics and associated with our Experimentation add-on. You do not need to update your
actions to use <code>metric</code>, however. If you are using goals actions, they will still work.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createMetric'   # Multiple commands are supported
      notes <<-'END'
        Create metrics.

      END
    end


          
    entry do
      command 'deleteMetric'   # Multiple commands are supported
      notes <<-'END'
        Delete metrics.

      END
    end


          
    entry do
      command 'updateEventKey'   # Multiple commands are supported
      notes <<-'END'
        Change the event key for a custom metric.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Update metric's names.

      END
    end


          
    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Update metric's descriptions.

      END
    end


          
    entry do
      command 'updateUrls'   # Multiple commands are supported
      notes <<-'END'
        Update the URLs for a click or page view metric.

      END
    end


          
    entry do
      command 'updateSelector'   # Multiple commands are supported
      notes <<-'END'
        Update the CSS selector for a click metric.

      END
    end


          
    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Mark a metric as active or inactive.

      END
    end


          
    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Change the tags associated with a metric.

      END
    end


          
    entry do
      command 'updateNumeric'   # Multiple commands are supported
      notes <<-'END'
        Mark a custom metric as numeric or non-numeric.

      END
    end


          
    entry do
      command 'updateNumericUnit'   # Multiple commands are supported
      notes <<-'END'
        Update the unit displayed in results for a numeric custom metric.

      END
    end


          
    entry do
      command 'updateNumericSuccess'   # Multiple commands are supported
      notes <<-'END'
        Update the success criteria for a numeric custom metric.

      END
    end


          
    entry do
      command 'updateMaintainer'   # Multiple commands are supported
      notes <<-'END'
        Change the metric's maintainer.

      END
    end

  end

  category do
    id 'Feature flags'
    entry do
      notes 'Resource'
    end
    entry do
      command 'flag'   # Multiple commands are supported
      command 'proj/*:env/*:flag/*'
      index_name 'Resource'
      extra_index_name 'Feature flags'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>flag</code> is a child of <strong>both a project and environments</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createFlag'   # Multiple commands are supported
      notes <<-'END'
        Create a feature flag. Creating a feature flag impacts all environments in a project, so users will need
        permission to create flags in all environments.

      END
    end


          
    entry do
      command 'cloneFlag'   # Multiple commands are supported
      notes <<-'END'
        Create a new flag with settings based on an existing flag. To clone a flag, you need to have the{' '}
        <code>cloneFlag</code> permission on the source flag, as well as the <code>createFlag</code> permission for the
        new flag

      END
    end


          
    entry do
      command 'deleteFlag'   # Multiple commands are supported
      notes <<-'END'
        Delete a feature. Deleting a feature impacts all environments in a project, so users will need permission to
        delete features in all environments.

      END
    end


          
    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Toggle a feature off

      END
    end


          
    entry do
      command 'updateIncludeInSnippet'   # Multiple commands are supported
      notes <<-'END'
        Change whether the feature flag is available to front-end code with the{' '}
        <a href="/sdk/client-side/javascript">JavaScript SDK</a>. Impacts all environments in a project.

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
      command 'updateClientSideFlagAvailability'   # Multiple commands are supported
      notes <<-'END'
        Change whether the feature flag is available to client-side SDKs.

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
        Update individual user targeting rules.

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
      command 'updateOffVariation'   # Multiple commands are supported
      notes <<-'END'
        Update the variation returned when flag toggle is set to `off`.

      END
    end


          
    entry do
      command 'updateMaintainer'   # Multiple commands are supported
      notes <<-'END'
        Update the flag maintainer. Impacts all environments.

      END
    end


          
    entry do
      command 'updateFlagVariations'   # Multiple commands are supported
      notes <<-'END'
        Change the flag's variations. Impacts all environments.

      END
    end


          
    entry do
      command 'updateFlagDefaultVariations'   # Multiple commands are supported
      notes <<-'END'
        Change the default flag variations used by newly created environments for a feature flag.

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
      command 'createExperiment'   # Multiple commands are supported
      notes <<-'END'
        Create an experiment.

      END
    end


          
    entry do
      command 'deleteExperiment'   # Multiple commands are supported
      notes <<-'END'
        Delete an experiment.

      END
    end


          
    entry do
      command 'deleteExperimentResults'   # Multiple commands are supported
      notes <<-'END'
        Delete experiment results.

      END
    end


          
    entry do
      command 'updateExperimentActive'   # Multiple commands are supported
      notes <<-'END'
        Start or stop an experiment in an environment.

      END
    end


          
    entry do
      command 'updateExperimentBaseline'   # Multiple commands are supported
      notes <<-'END'
        Change a flag's baseline variation for experiments.

      END
    end


          
    entry do
      command 'updateAttachedGoals'   # Multiple commands are supported
      notes <<-'END'
        Start or stop an A/B testing experiment.

      END
    end


          
    entry do
      command 'deleteFlagAttachedGoalResults'   # Multiple commands are supported
      notes <<-'END'
        Reset the experiment results for a flag in a given environment.

      END
    end


          
    entry do
      command 'copyFlagConfigFrom'   # Multiple commands are supported
      notes <<-'END'
        Copy settings from a feature flag.

      END
    end


          
    entry do
      command 'copyFlagConfigTo'   # Multiple commands are supported
      notes <<-'END'
        Copy settings to a feature flag.

      END
    end


          
    entry do
      command 'updateFlagSalt'   # Multiple commands are supported
      notes <<-'END'
        Update a feature flag's salt.

      END
    end


          
    entry do
      command 'updateTrackEvents'   # Multiple commands are supported
      notes <<-'END'
        Change whether to send detailed event information for a flag in a given environment.

      END
    end


          
    entry do
      command 'updateFlagFallthroughTrackEvents'   # Multiple commands are supported
      notes <<-'END'
        Change whether to send detailed event information for a flag in a given environment when the fallthrough variation was selected.

      END
    end


          
    entry do
      command 'updateGlobalArchived'   # Multiple commands are supported
      notes <<-'END'
        Change whether a flag is archived.

      END
    end


          
    entry do
      command 'updateExpiringRules'   # Multiple commands are supported
      notes <<-'END'
        Change a flag's expiring custom targeting rules.

      END
    end


          
    entry do
      command 'updateExpiringTargets'   # Multiple commands are supported
      notes <<-'END'
        Change a flag's expiring individual user targeting rules.

      END
    end


          
    entry do
      command 'updateFeatureWorkflows'   # Multiple commands are supported
      notes <<-'END'
        Change a flag's feature workflows.

      END
    end


          
    entry do
      command 'updateScheduledChanges'   # Multiple commands are supported
      notes <<-'END'
        Change the scheduled updates on a feature flag.

      END
    end


          
    entry do
      command 'updateTriggers'   # Multiple commands are supported
      notes <<-'END'
        Manage trigger configurations.

      END
    end


          
    entry do
      command 'updateTriggers'   # Multiple commands are supported
      notes <<-'END'
        Create a new trigger, edit existing flag triggers, or delete an existing trigger.

      END
    end


          
    entry do
      command 'createApprovalRequest'   # Multiple commands are supported
      notes <<-'END'
        Create an approval request for a flag.

      END
    end


          
    entry do
      command 'updateApprovalRequest'   # Multiple commands are supported
      notes <<-'END'
        Update an existing approval request for a flag.

      END
    end


          
    entry do
      command 'deleteApprovalRequest'   # Multiple commands are supported
      notes <<-'END'
        Delete an approval request for a flag.

      END
    end


          
    entry do
      command 'reviewApprovalRequest'   # Multiple commands are supported
      notes <<-'END'
        Review an approval request for a flag.

      END
    end


          
    entry do
      command 'applyApprovalRequest'   # Multiple commands are supported
      notes <<-'END'
        Apply an approved approval request for a flag.

      END
    end

  end

  category do
    id 'Segments'
    entry do
      notes 'Resource'
    end
    entry do
      command 'segment'   # Multiple commands are supported
      command 'proj/*:env/*:segment/*'
      index_name 'Resource'
      extra_index_name 'Segments'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>segment</code> is a child of <strong>both a project and environments</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createSegment'   # Multiple commands are supported
      notes <<-'END'
        Create new segments.

      END
    end


          
    entry do
      command 'deleteSegment'   # Multiple commands are supported
      notes <<-'END'
        Delete segments.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Rename a segment.

      END
    end


          
    entry do
      command 'updateDescription'   # Multiple commands are supported
      notes <<-'END'
        Update a segment's description.

      END
    end


          
    entry do
      command 'updateTags'   # Multiple commands are supported
      notes <<-'END'
        Change the tags associated with a segment.

      END
    end


          
    entry do
      command 'updateIncluded'   # Multiple commands are supported
      notes <<-'END'
        Change a segment's included users.

      END
    end


          
    entry do
      command 'updateExcluded'   # Multiple commands are supported
      notes <<-'END'
        Change a segment's excluded users.

      END
    end


          
    entry do
      command 'updateRules'   # Multiple commands are supported
      notes <<-'END'
        Change a segment's custom targeting rules.

      END
    end


          
    entry do
      command 'updateExpiringRules'   # Multiple commands are supported
      notes <<-'END'
        Change a segment's expiring custom targeting rules.

      END
    end


          
    entry do
      command 'updateExpiringTargets'   # Multiple commands are supported
      notes <<-'END'
        Change a segment's expiring individual user targeting rules.

      END
    end


          
    entry do
      command 'updateScheduledChanges'   # Multiple commands are supported
      notes <<-'END'
        Change the scheduled updates on a segment.

      END
    end

  end

  category do
    id 'Webhooks'
    entry do
      notes 'Resource'
    end
    entry do
      command 'webhook'   # Multiple commands are supported
      command 'webhook/*'
      index_name 'Resource'
      extra_index_name 'Webhooks'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>webhook</code> is a <strong>top-level resource</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createWebhook'   # Multiple commands are supported
      notes <<-'END'
        Create new webhooks.

      END
    end


          
    entry do
      command 'deleteWebhook'   # Multiple commands are supported
      notes <<-'END'
        Delete existing webhooks.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of webhook configurations.

      END
    end


          
    entry do
      command 'updateUrl'   # Multiple commands are supported
      notes <<-'END'
        Change the URL for a webhook.

      END
    end


          
    entry do
      command 'updateSecret'   # Multiple commands are supported
      notes <<-'END'
        Modify an existing webhook's signing secret.

      END
    end


          
    entry do
      command 'updateStatements'   # Multiple commands are supported
      notes <<-'END'
        Modify webhook policy statements.

      END
    end


          
    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Enable and disabled existing webhooks.

      END
    end

  end

  category do
    id 'Integrations'
    entry do
      notes 'Resource'
    end
    entry do
      command 'integration'   # Multiple commands are supported
      command 'integration/*'
      index_name 'Resource'
      extra_index_name 'Integrations'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        Most third-party integrations use a shared set of custom role actions.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createIntegration'   # Multiple commands are supported
      notes <<-'END'
        Create and configure new third-party integrations.

      END
    end


          
    entry do
      command 'deleteIntegration'   # Multiple commands are supported
      notes <<-'END'
        Delete existing third-party integrations.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Change the name of third-party integration configurations.

      END
    end


          
    entry do
      command 'updateConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Modify existing third-party integration configurations.

      END
    end


          
    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Enable and disabled existing third-party integrations.

      END
    end

  end

  category do
    id 'Relay Proxy automatic configuration'
    entry do
      notes 'Resource'
    end
    entry do
      command 'relay-proxy-config'   # Multiple commands are supported
      command 'relay-proxy-config/*'
      index_name 'Resource'
      extra_index_name 'Relay Proxy automatic configuration'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>relay-proxy-config</code> is a top-level resource for which you can allow or deny certain actions.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createRelayAutoConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Create a Relay Proxy with automatic configuration enabled

      END
    end


          
    entry do
      command 'updateRelayAutoConfigurationName'   # Multiple commands are supported
      notes <<-'END'
        Change the Relay Proxy with automatic configuration's name

      END
    end


          
    entry do
      command 'updateRelayAutoConfigurationPolicy'   # Multiple commands are supported
      notes <<-'END'
        Change the policies associated with the Relay Proxy with automatic configuration

      END
    end


          
    entry do
      command 'deleteRelayAutoConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Delete the Relay Proxy with automatic configuration enabled

      END
    end


          
    entry do
      command 'resetRelayAutoConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Resets the configuration of the Relay Proxy with automatic configuration enabled

      END
    end

  end

  category do
    id 'Destinations'
    entry do
      notes 'Resource'
    end
    entry do
      command 'destination'   # Multiple commands are supported
      command 'proj/*:env/*:destination/*'
      index_name 'Resource'
      extra_index_name 'Destinations'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>destination</code> is a child of <strong>both a project and environments</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'createDestination'   # Multiple commands are supported
      notes <<-'END'
        Create a new data export destination.

      END
    end


          
    entry do
      command 'deleteDestination'   # Multiple commands are supported
      notes <<-'END'
        Delete a data export destination.

      END
    end


          
    entry do
      command 'updateConfiguration'   # Multiple commands are supported
      notes <<-'END'
        Change a data export destination.

      END
    end


          
    entry do
      command 'updateOn'   # Multiple commands are supported
      notes <<-'END'
        Flip the on/off status of a data export destination.

      END
    end


          
    entry do
      command 'updateName'   # Multiple commands are supported
      notes <<-'END'
        Rename a data export destination.

      END
    end

  end

  category do
    id 'Code references'
    entry do
      notes 'Resource'
    end
    entry do
      command 'code-reference-repository'   # Multiple commands are supported
      command 'code-reference-repository/*'
      index_name 'Resource'
      extra_index_name 'Code references'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>code-reference-repository</code> is a <strong>top-level resource</strong>.
      END
    end
    entry do
      notes 'Actions'
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
      command 'UpdateCodeRefsRepositoryOn'   # Multiple commands are supported
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

  category do
    id 'Users'
    entry do
      notes 'Resource'
    end
    entry do
      command 'user'   # Multiple commands are supported
      command 'proj/*:env/*:user/*'
      index_name 'Resource'
      extra_index_name 'Users'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        <code>user</code> is a child of <strong>both a project and environments</strong>.
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end

          
    entry do
      command 'deleteUser'   # Multiple commands are supported
      notes <<-'END'
        Delete a user.

      END
    end
  end
end